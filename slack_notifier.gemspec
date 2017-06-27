# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'slack_notifier/version'

Gem::Specification.new do |spec|
  spec.name          = "slack_notifier"
  spec.version       = SlackNotifier::VERSION
  spec.authors       = ['Elod Peter', 'Mohamed Osama']
  spec.email         = ['bejmuller@gmail.com', 'mohamed.o.alnagdy@gmail.com']

  spec.summary       = %q{Simple Ruby gem for sending messages to Slack}
  spec.description   = %q{Simple Ruby gem for sending messages to Slack}
  spec.homepage      = "https://github.com/FindHotel/ruby_slack_notifier"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'titleize', '~> 1.4'

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
