module Hyper
  module Core
    module Service
      class Configuration
        HOST_URL = 'app.hyp3r.co'
        PREFIX = 'api'
        API_VERSION = 3
        PRODUCT = 'engage'

        attr_writer :host, :prefix, :version, :product
        attr_accessor :email, :token, :organization_id

        def host
          @host ||= HOST_URL
        end

        def prefix
          @prefix ||= PREFIX
        end

        def version
          @version ||= API_VERSION
        end

        def product
          @product ||= PRODUCT
        end

        def base_url
          "#{protocol}#{host}/#{prefix}/#{version_string}"
        end

        private

        def protocol
          'https://'
        end

        def version_string
          "v#{version}"
        end
      end
    end
  end
end
