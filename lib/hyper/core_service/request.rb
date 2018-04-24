module Hyper
  module CoreService
    class Request
      def initialize
        @config = Config.new
        yield @config if block_given?
        @connection = Connection.new(config.base)
      end

      def run(user)
        response = connection.post(config.path, nil, headers_for(user))
        handle_errors(response)
        response
      end

      private

      attr_reader :connection, :config

      def headers_for(user)
        {
          'X-Entity-Token' => user.fetch(:authentication_token),
          'X-Entity-Email' => user.fetch(:email)
        }
      rescue KeyError => e
        raise InvalidUserObjectError, e.message
      end

      def handle_errors(response)
        raise InternalServerError if (500..599).member?(response.status)
        raise UnauthorizedUserError, JSON.parse(response.body)['error'] if response.body['error']
      end
    end
  end
end
