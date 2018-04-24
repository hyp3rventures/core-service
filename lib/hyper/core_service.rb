require 'json'
require 'faraday'
require 'hyper/core_service/connection'
require 'hyper/core_service/errors'
require 'hyper/core_service/request'
require 'hyper/core_service/version'
require 'hyper/core_service/config'

module Hyper
  module CoreService
    class << self
      def new(&block)
        Request.new(&block)
      end
    end
  end
end
