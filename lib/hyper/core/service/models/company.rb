module Hyper
  module Core
    module Service
      class Company < Base
        PROPERTIES = [
          :command_center_enabled,
          :countries,
          :created_at,
          :id,
          :name,
          :total_clusters,
          :total_venues,
          :updated_at,
          :url
        ]

        attr_accessor *PROPERTIES
      end
    end
  end
end
