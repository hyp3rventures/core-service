module Hyper
  module Core
    module Service
      class Permissions
        def initialize(user)
          @user = user
          @product = user.permissions_json.fetch(Core::Service.configuration.product) { {} }
        end

        def admin?
          has_role?('admin')
        end

        def read?
          admin? || has_role?('read') || public_user?
        end

        def write?
          admin? || has_role?('write')
        end

        def public_user?
          product.fetch('public_user') { false }
        end

        private

        attr_reader :user, :product

        def roles
          organizations.dig(user.organization_id.to_s, 'roles') || []
        end

        def organizations
          product.fetch('organizations') { {} }
        end

        def has_role?(role)
          roles.include?(role)
        end
      end
    end
  end
end
