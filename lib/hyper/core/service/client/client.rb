module Hyper
  module Core
    module Service
      module Client
        def connection
          Faraday.new(url: Core::Service.configuration.base_url) do |faraday|
            faraday.request :url_encoded # form-encode POST params
            faraday.headers['X-Entity-Email'] = Core::Service.configuration.email
            faraday.headers['X-Entity-Token'] = Core::Service.configuration.token
            faraday.headers['X-Entity-Organization-Id'] = Core::Service.configuration.organization_id.to_s
            faraday.headers['Content-Type'] = 'application/json'
            faraday.adapter Faraday.default_adapter # make requests with Net::HTTP
          end
        end

        def request(verb, endpoint, *args, scope_to_organization: true, **kwargs)
          response = connection.send(verb.to_sym) do |req|
            req.url File.join(endpoint, *args.map(&:to_s))

            if scope_to_organization
              kwargs.delete(:scope_to_organization)
              kwargs.merge!(organization_id: Core::Service.configuration.organization_id)
            end

            req.params.merge!(kwargs) if kwargs.present?
          end
          handle_errors(response)
          parse(response)
        end

        def get(*args, **kwargs)
          request(:get, *args, **kwargs)
        end

        def post(*args, **kwargs)
          request(:post, *args, **kwargs)
        end

        def parse(response)
          resp = JSON.parse(response.body, symbolize_names: true)
          if resp.is_a?(Array)
            resp.map!(&:with_indifferent_access)
          else
            resp.with_indifferent_access
          end
        end

        def handle_errors(response)
          case response.status
          when 404 then
            raise NotFoundError
          when (400..499) then
            raise Error
          when (500..599) then
            raise InternalServerError
          end
          raise UnauthorizedUserError, JSON.parse(response.body)['error'] if response.body['error']
        end
      end
    end
  end
end
