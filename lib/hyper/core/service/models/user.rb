module Hyper
  module Core
    module Service
      class User < Base
        PROPERTIES = [
          :authentication_token,
          :avatar,
          :company,
          :company_id,
          :created_at,
          :eid,
          :email,
          :first_name,
          :id,
          :last_name,
          :organization_count,
          :organization_id,
          :organization_ids,
          :permissions_json,
          :phone_number,
          :settings,
          :time_zone,
          :updated_at,
          :website
        ]

        attr_accessor *PROPERTIES

        class << self
          def build(blob)
            if blob.keys.length == 1 && blob.key?(:user)
              blob = blob.delete(:user)
            end
            blob[:permissions_json] = blob.delete(:permissions)
            props = blob.slice(*PROPERTIES).merge(organization_id: Core::Service.configuration.organization_id)
            new(props)
          end

          def authenticate
            build(user: post('authentications', 'verify').result)
          end
        end

        def permissions
          Permissions.new(self)
        end

        def name
          "#{first_name} #{last_name}"
        end
      end
    end
  end
end

