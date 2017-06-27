require 'json'
require 'titleize'
require 'slack_notifier/config'
require 'slack_notifier/message'
require 'slack_notifier/version'

module SlackNotifier
  def self.configure(config)
    Config.set(config)
  end
end
