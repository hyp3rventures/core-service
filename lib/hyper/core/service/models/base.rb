module Hyper
  module Core
    module Service
      class Base
        include ActiveModel::Model
        extend Client

        class << self
          attr_accessor :resource_url, :scope

          def all
            where(resource_url)
          end

          def find(id)
            build(get(resource_url, id))
          end

          def where(**options)
            get(resource_url, **options).map { |obj| build(obj) }
          end

          def build(blob)
            new(blob.slice(*self::PROPERTIES))
          end
        end
      end
    end
  end
end
