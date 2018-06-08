require 'bundler/setup'
require 'hyper/core/service'
require 'webmock/rspec'
require 'factory_bot'
require 'support/test_object'
require 'pry'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = 'spec/examples.txt'
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.order = :random
  Kernel.srand config.seed

  config.disable_monkey_patching!
  config.filter_run_when_matching :focus

  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    FactoryBot.find_definitions

    Hyper::Core::Service.configure do |hyper_config|
      hyper_config.email = 'user@example.com'
      hyper_config.token = 'abcd1234'
      hyper_config.organization_id = 3
      hyper_config.host = 'www.example.com'
    end
  end
end
