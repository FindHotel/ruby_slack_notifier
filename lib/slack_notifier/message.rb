module SlackNotifier
  class Message
    def self.send(text:, channel: nil, nickname: nil, icon_emoji: nil, icon_url: nil, report: nil)
      channel ||= Config.default_channel
      nickname ||= Config.default_nickname
      new(text, channel, nickname, icon_emoji, icon_url, report).tap(&:deliver)
    rescue => ex
      raise ex if Config.raise_delivery_errors
      puts ex.message
      puts ex.backtrace.join("\n")
    end

    def deliver
      payload_hash = {
          username: @nickname,
          text: @message.gsub('\'', '`'),
          channel: @channel
      }

      payload_hash.merge!(icon_param)
      payload_hash.merge!(compose_attachment) if !@report.nil? && !@report.empty?

      payload = payload_hash.to_json

      cmd = %(curl -X POST --data-urlencode 'payload=#{payload}' #{Config.webhook_url})
      puts "Executing: `#{cmd}`"

      result = `#{cmd}`
      puts "Result: #{result}"

      Time.now
    end

    private

    def initialize(message, channel, nickname, icon, icon_ur, report)
      @message = message
      @channel = channel
      @nickname = nickname
      @created_at = Time.now
      @report = report

      set_icon(icon, icon_ur)
    end

    def icon_param
      @icon_emoji ? { icon_emoji: @icon_emoji } : { icon_url: @icon_url }
    end

    def set_icon(icon_emoji, icon_url)
      if no_icon?(icon_emoji, icon_url)
        @icon_emoji = Config.default_icon_emoji
      end

      if more_than_one_icon?(icon_emoji, icon_url)
        fail 'Please specify either an icon_emoji or an icon_url'
      end

      if icon_emoji
        @icon_emoji = icon_emoji
      else
        @icon_url = icon_url
      end
    end

    def no_icon?(icon_emoji, icon_url)
      icon_emoji.nil? && icon_url.nil?
    end

    def more_than_one_icon?(icon_emoji, icon_url)
      !icon_emoji.nil? && !icon_url.nil?
    end

    def compose_attachment
      {
          attachments: [
              {
                  title: Config.default_report_title,
                  color: Config.default_report_color,
                  text: key_value_pairs_to_s(@report)
              }
          ]
      }
    end

    def key_value_pairs_to_s(hash)
      hash.map { |k, v| "#{k}: #{v}" }.join("\n")
    end
  end
end
