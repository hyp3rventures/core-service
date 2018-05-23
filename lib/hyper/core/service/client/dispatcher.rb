module Hyper
  module Core
    module Service
      class Dispatcher
        attr_reader :request_method, :endpoint, :arguments, :options, :result, :connection

        def initialize(request_method, endpoint, *arguments, **options)
          @request_method = request_method
          @endpoint = endpoint
          @arguments = arguments
          @options = options
          @connection = Hyper::Core::Service.connection
        end

        def call
          handle_errors(response)
          @result = Serializer.new(response.body, endpoint).run
          self
        end

        def response
          @response ||= connection.send(request_method.to_sym) do |request|
            request.url url
            request.params.merge!(params)
          end
        end

        def url
          [endpoint, *arguments.map(&:to_s)].compact.join('/')
        end

        def params
          options.merge!(
            organization_id: Hyper::Core::Service.configuration.organization_id
          )
        end

        private

        def handle_errors(response)
          case response.status
          when 401, 403
            raise UnauthorizedUserError, response.body
          when 404
            raise NotFoundError, response.body
          when (400..499)
            raise Error, response.body
          when (500..599)
            raise InternalServerError, response.body
          end
        end
      end
    end
  end
end
