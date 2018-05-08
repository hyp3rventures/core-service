require 'json'
require 'faraday'
require 'active_model'
require 'active_support/core_ext/hash/indifferent_access'
require_relative 'service/errors'
require_relative 'service/version'
require_relative 'service/configuration'
require_relative 'service/models'

module Hyper
  module Core
    module Service
      class << self
        def configuration
          @configuration ||= Configuration.new
        end

        def configure
          yield(configuration)
        end
      end
    end
  end
end
