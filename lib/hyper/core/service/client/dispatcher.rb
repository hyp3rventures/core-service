module Hyper
  module Core
    module Service
      class Dispatcher
        attr_reader :request_method, :endpoint, :arguments, :options, :result, :connection
        attr_accessor :object_key

        def initialize(request_method, endpoint, *arguments, **options)
          @request_method = request_method.to_sym
          @endpoint = endpoint
          @arguments = arguments
          @options = options
          @object_key ||= options.key?(:object_key) ? options.delete(:object_key) : endpoint
          @connection = Hyper::Core::Service.connection(versioned_base_url)
        end

        def call
          handle_errors(response)
          @result = Serializer.new(response.body, object_key).run
          self
        end

        def response
          @response ||= connection.send(request_method) do |request|
            request.url url
            request.params.merge!(params) if request_method == :get
            request.body = params.to_json if request_method == :post
          end
        end

        def url
          [endpoint, *arguments.compact].flat_map(&:to_s).join('/')
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

        def versioned_base_url
          !endpoint.include?(Hyper::Core::Service::Configuration::NON_VERSIONED_API_PATH)
        end
      end
    end
  end
end
