module SlackNotifier
  class Config
    DEFAULT_ATTACHMENT_TITLE = 'Details'
    DEFAULT_ATTACHMENT_COLOR = '#D3D3D3'

    class << self
      attr_reader :default_channel, :default_nickname, :default_icon_emoji, :attachment_color,
                  :attachment_title, :webhook_url, :raise_delivery_errors

      def set(config)
        @default_channel = config[:default_channel]
        @default_nickname = config[:default_nickname]
        @default_icon_emoji = config[:default_icon_emoji]
        @attachment_title = config[:attachment_title] || DEFAULT_ATTACHMENT_TITLE
        @attachment_color = config[:attachment_color] || DEFAULT_ATTACHMENT_COLOR
        @webhook_url = config[:webhook_url]
        @raise_delivery_errors = config[:raise_delivery_errors]
      end
    end
  end
end
