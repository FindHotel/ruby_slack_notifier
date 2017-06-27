module SlackNotifier
  class Message
    def self.send(text:, channel: nil, nickname: nil, icon_emoji: nil, report: nil, report_color: nil)
      channel ||= Config.default_channel
      nickname ||= Config.default_nickname
      icon = icon_emoji || Config.default_icon_emoji
      report_color = report_color || Config.default_report_color
      new(text, channel, nickname, icon, report, report_color).tap(&:deliver)
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

    def initialize(message, channel, nickname, icon, report, report_color)
      @message = message
      @channel = channel
      @nickname = nickname
      @icon_emoji = icon
      @report = report
      @report_color = report_color
      @created_at = Time.now
    end

    def icon_param
      { icon_emoji: @icon_emoji }
    end

    def compose_attachment
      {
          attachments: [
              {
                  title: Config.default_report_title,
                  color: @report_color,
                  text: key_value_pairs_to_s(@report)
              }
          ]
      }
    end

    def key_value_pairs_to_s(hash)
      hash.map { |k, v| "#{k.to_s.gsub(/_/, ' ').titleize}: #{v}" }.join("\n")
    end
  end
end
