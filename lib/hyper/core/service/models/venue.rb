module Hyper
  module Core
    module Service
      class Venue < Base
        self.resource_scope = 'organization'

        PROPERTIES = [
          :alr,
          :city,
          :company_id,
          :competitive,
          :country,
          :cover_photo_url,
          :created_at,
          :geo_fence,
          :id,
          :name,
          :organizations,
          :search_geo_point,
          :source,
          :time_zone,
          :updated_at
        ]

        attr_accessor *PROPERTIES
      end
    end
  end
end


