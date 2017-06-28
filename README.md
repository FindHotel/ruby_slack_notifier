[![Gem Version](https://img.shields.io/gem/v/slack_notifier.svg)](https://rubygems.org/gems/slack_notifier)
[![Master](https://travis-ci.org/FindHotel/ruby_slack_notifier.svg?branch=master)](https://travis-ci.org/FindHotel/ruby_slack_notifier)

# SlackNotifier

Simple Ruby gem for sending messages to Slack

<img width="800" alt="slack notifier" src="https://user-images.githubusercontent.com/6284234/27587063-3037ceba-5b43-11e7-82a6-fbe2c13952f2.png">

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
  default_report_title: 'Details',
  default_report_color: '#D3D3D3',
  webhook_url: 'https://hooks.slack.com/services/X01XXYY11/A1XXY1X00/YYYYYYYYYYYYYYYYYY',
  raise_delivery_errors: false
})
```

## Usage
### Send directly
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
  icon_emoji: ':bug:',
  report: ex.backtrace,
  report_color: '#D3D3D3',
  report_title: 'Backtrace'
)
```

### Send later
```ruby
message = SlackNotifier::Message.compose(
  text: "This uses all default configuration",
  report: 'Some report/attachment text'
)

message.deliver
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/FindHotel/ruby_slack_notifier.
