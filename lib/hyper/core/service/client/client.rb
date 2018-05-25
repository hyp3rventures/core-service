module Hyper
  module Core
    module Service
      module Client
        def get(endpoint, *args, **kwargs)
          request(:get, endpoint, *args, kwargs)
        end

        def post(endpoint, *args, **kwargs)
          request(:post, endpoint, *args, kwargs)
        end

        private

        def request(request_method, endpoint, *args, **kwargs)
          Dispatcher.new(request_method, endpoint, *args, kwargs).call
        end
      end
    end
  end
end
