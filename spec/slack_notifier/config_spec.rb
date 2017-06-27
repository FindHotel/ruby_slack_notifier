describe SlackNotifier::Config do
  describe 'set' do
    let(:configuration) {
      {
        default_channel: 'deployment-alerts',
        default_nickname: 'Deployment Bot',
        default_icon_emoji: ':ship:',
        attachment_title: 'Details',
        attachment_color: '#D3D3D3',
        webhook_url: 'https://hooks.slack.com/services/X01XXYY11/A1XXY1X00/YYYYYYYYYYYYYYYYYY',
        raise_delivery_errors: false
      }
    }

    before do
      SlackNotifier::Config.set(configuration)
    end

    it 'sets default_channel' do
      expect(SlackNotifier::Config.default_channel).to eq('deployment-alerts')
    end

    it 'sets default_nickname' do
      expect(SlackNotifier::Config.default_nickname).to eq('Deployment Bot')
    end

    it 'sets default_icon_emoji' do
      expect(SlackNotifier::Config.default_icon_emoji).to eq(':ship:')
    end

    it 'sets attachment_title' do
      expect(SlackNotifier::Config.attachment_title).to eq('Details')
    end

    it 'sets attachment_color' do
      expect(SlackNotifier::Config.attachment_color).to eq('#D3D3D3')
    end

    it 'sets webhook_url' do
      expect(SlackNotifier::Config.webhook_url).
        to eq('https://hooks.slack.com/services/X01XXYY11/A1XXY1X00/YYYYYYYYYYYYYYYYYY')
    end

    it 'sets raise_delivery_errors' do
      expect(SlackNotifier::Config.raise_delivery_errors).to eq(false)
    end
  end
end
