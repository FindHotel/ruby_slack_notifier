module SlackNotifier
  class Config
    PRESET_REPORT_TITLE = 'Details'
    PRESET_REPORT_COLOR = '#D3D3D3'

    class << self
      attr_reader :default_channel, :default_nickname, :default_icon_emoji, :default_report_color,
                  :default_report_title, :webhook_url, :raise_delivery_errors

      def set(config)
        @default_channel = config[:default_channel]
        @default_nickname = config[:default_nickname]
        @default_icon_emoji = config[:default_icon_emoji]
        @default_report_title = config[:default_report_title] || PRESET_REPORT_TITLE
        @default_report_color = config[:default_report_color] || PRESET_REPORT_COLOR
        @webhook_url = config[:webhook_url]
        @raise_delivery_errors = config[:raise_delivery_errors]
      end
    end
  end
end
