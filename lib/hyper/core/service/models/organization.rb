module Hyper
  module Core
    module Service
      class Organization < Base
        self.resource_scope = 'company'

        PROPERTIES = [
          :company_id,
          :id,
          :name,
          :total_venues
        ]

        attr_accessor *PROPERTIES
      end
    end
  end
end
