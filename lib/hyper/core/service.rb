require 'json'
require 'faraday'
require 'active_model'
require 'active_support/core_ext/string/inflections'
require 'active_support/core_ext/hash/indifferent_access'
require 'active_support/core_ext/hash/except'

require_relative 'service/errors'
require_relative 'service/version'
require_relative 'service/configuration'
require_relative 'service/client'
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

        def connection
          Faraday.new(url: configuration.base_url) do |faraday|
            faraday.request :url_encoded # form-encode POST params
            faraday.headers['X-Entity-Email'] = configuration.email
            faraday.headers['X-Entity-Token'] = configuration.token
            faraday.headers['X-Entity-Organization-Id'] = configuration.organization_id.to_s
            faraday.headers['Content-Type'] = 'application/json'
            faraday.adapter Faraday.default_adapter # make requests with Net::HTTP
          end
        end
      end
    end
  end
end
