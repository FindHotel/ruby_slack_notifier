describe SlackNotifier do
  describe 'configure' do
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

    after do
      SlackNotifier.configure(configuration)
    end

    it 'set config' do
      expect(SlackNotifier::Config).to receive(:set).with(configuration)
    end
  end
end
