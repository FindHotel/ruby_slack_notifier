# SlackNotifier

Simple Ruby gem for sending messages to Slack

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'slack_notifier'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install slack_notifier

## Configuration

```ruby
SlackNotifier.configure({
  default_channel: 'deployment-alerts',
  default_nickname: 'Deployment Bot',
  default_icon_emoji: ':ship:',
  attachment_title: 'Details',
  attachment_color: '#D3D3D3',
  webhook_url: 'https://hooks.slack.com/services/X01XXYY11/A1XXY1X00/YYYYYYYYYYYYYYYYYY',
  raise_delivery_errors: false
})
```

## Usage
```ruby
SlackNotifier::Message.send(
  text: "This uses all default configuration",
  report: 'Some report/attachment text'
)

# Customizing default configuration
SlackNotifier::Message.send(
  channel: 'errors',
  nickname: 'Bugs',
  text: ex.message,
  report: ex.backtrace
)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/FindHotel/ruby_slack_notifier.
