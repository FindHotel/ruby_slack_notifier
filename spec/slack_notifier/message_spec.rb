describe SlackNotifier::Message do
  let(:configuration) {
    {
      default_channel: 'deployment-alerts',
      default_nickname: 'Deployment Bot',
      default_icon_emoji: ':ship:',
      default_report_title: 'Details',
      default_report_color: '#D3D3D3',
      webhook_url: 'https://hooks.slack.com/services/X01XXYY11/A1XXY1X00/YYYYYYYYYYYYYYYYYY',
      raise_delivery_errors: false
    }
  }

  before do
    SlackNotifier.configure(configuration)
  end

  describe 'compose' do
    it 'should respond to :compose' do
      expect(SlackNotifier::Message).to respond_to(:compose)
    end

    it 'requires a text' do
      expect{ SlackNotifier::Message.compose }.
        to raise_error(ArgumentError, 'missing keyword: text')
    end

    describe 'when only a text is provided' do
      let(:message) { SlackNotifier::Message.compose(text: 'Slack Notifier Example') }

      it 'set message text' do
        expect(message.instance_variable_get(:@text)).to eq('Slack Notifier Example')
      end

      it 'composes a proper slack message with default channel' do
        expect(message.instance_variable_get(:@channel)).
          to eq(SlackNotifier::Config.default_channel)
      end

      it 'composes a proper slack message with default nickname' do
        expect(message.instance_variable_get(:@nickname)).
          to eq(SlackNotifier::Config.default_nickname)
      end

      it 'composes a proper slack message with default icon_emoji' do
        expect(message.instance_variable_get(:@icon_emoji)).
          to eq(SlackNotifier::Config.default_icon_emoji)
      end

      it 'composes a proper slack message with default report_color' do
        expect(message.instance_variable_get(:@report_color)).
          to eq(SlackNotifier::Config.default_report_color)
      end

      it 'composes a proper slack message with default report_title' do
        expect(message.instance_variable_get(:@report_title)).
          to eq(SlackNotifier::Config.default_report_title)
      end
    end
  end

  describe 'send' do
    it 'should respond to :send' do
      expect(SlackNotifier::Message).to respond_to(:send)
    end
  end

  # Private methods

  describe 'payload' do
    let(:message) do
      SlackNotifier::Message.compose(
        text: 'Lunch is klaar!',
        nickname: 'FindHotel Lunch Bot',
        channel: 'food',
        icon_emoji: ':fork_and_knife:',
        report: { menu: 'Tortellini al Tartufo e Rigatoni alla Bolognese' },
        report_title: 'What is for lunch today?',
        report_color: '#997EC3')
    end

    let(:json_payload) do
      ({
        username: 'FindHotel Lunch Bot',
        text: 'Lunch is klaar!',
        channel: 'food',
        icon_emoji: ':fork_and_knife:',
        attachments: [
          {
            title: 'What is for lunch today?',
            color: '#997EC3',
            text: "Menu: Tortellini al Tartufo e Rigatoni alla Bolognese"
          }
        ]
      }).to_json
    end

    it 'assembles proper payload' do
      expect(message.__send__(:payload)).to eq(json_payload)
    end
  end
end
