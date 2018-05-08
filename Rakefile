require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'dotenv/tasks'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

task :console => :dotenv do
  require 'pry'
  require_relative 'lib/hyper/core/service'

  Hyper::Core::Service.configure do |config|
    config.email = ENV.fetch('HYPER_CORE_EMAIL')
    config.token = ENV.fetch('HYPER_CORE_TOKEN')
    config.host = ENV.fetch('HYPER_CORE_HOST')
    config.product = ENV.fetch('HYPER_CORE_PRODUCT')
    config.organization_id = ENV.fetch('HYPER_CORE_ORGANIZATION_ID')
  end

  ARGV.clear
  Pry.start
end
