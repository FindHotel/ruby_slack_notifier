module SlackNotifier
  class Message
    def self.compose(text:, channel: nil, nickname: nil, icon_emoji: nil, report: nil, report_title: nil, report_color: nil)
      channel ||= Config.default_channel
      nickname ||= Config.default_nickname
      icon_emoji ||= Config.default_icon_emoji
      report_color ||= Config.default_report_color
      report_title ||= Config.default_report_title
      new(text, channel, nickname, icon_emoji, report, report_title, report_color)
    end

    def self.send(text:, channel: nil, nickname: nil, icon_emoji: nil, report: nil, report_title: nil, report_color: nil)
      compose(
        text: text,
        channel: channel,
        nickname: nickname,
        icon_emoji: icon_emoji,
        report: report,
        report_title: report_title,
        report_color: report_color
      ).tap(&:deliver)
    rescue => ex
      raise ex if Config.raise_delivery_errors
      puts ex.message
      puts ex.backtrace.join("\n")
    end

    def deliver
      cmd = %(curl -X POST --data-urlencode 'payload=#{payload}' #{Config.webhook_url})
      puts "Executing: `#{cmd}`"

      result = `#{cmd}`
      puts "Result: #{result}"

      Time.now
    end

    private

    def initialize(text, channel, nickname, icon, report, report_title, report_color)
      @text = text
      @channel = channel
      @nickname = nickname
      @icon_emoji = icon
      @report = report
      @report_title = report_title
      @report_color = report_color
      @created_at = Time.now
    end

    def payload
      payload_hash = base_param
      payload_hash.merge!(icon_param)
      payload_hash.merge!(attachment_param)
      payload_hash.to_json
    end

    def base_param
      {
          username: @nickname,
          text: @text.gsub('\'', '').gsub('`', ''),
          channel: @channel
      }
    end

    def icon_param
      { icon_emoji: @icon_emoji }
    end

    def attachment_param
      return {} if @report.nil? || @report.empty?
      {
          attachments: [
              {
                  title: @report_title,
                  color: @report_color,
                  text: key_value_pairs_to_s(@report)
              }
          ]
      }
    end

    def key_value_pairs_to_s(hash)
      hash.map do |k, v|
        "#{k.to_s.gsub(/_/, ' ').titleize}: #{v.to_s.gsub('\'', '').gsub('`', '')}"
      end.join("\n")
    end
  end
end
