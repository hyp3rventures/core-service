module Hyper
  module Core
    module Service
      class Base
        include ActiveModel::Model
        extend Client

        class << self
          attr_accessor :resource_url, :resource_scope

          def resource_url
            @resource_url ||= name.demodulize.underscore.pluralize
          end

          def find(id)
            build(get(resource_url, id).result)
          end

          def where(**options)
            if resource_scope
              raise MissingParamsError, resource_scope unless options.key?("#{resource_scope}_id".to_sym)
            end
            build_collection(get(resource_url, **options).result)
          end

          alias_method :all, :where

          def build(blob)
            new(blob.slice(*self::PROPERTIES))
          end

          def build_collection(blobs)
            blobs.map { |obj| build(obj) }
          end

          def inherited(klass)
            klass.instance_exec(resource_scope) do |scope|
              self.resource_scope = scope
            end
          end
        end

        def ==(other)
          id == other.id
        end
      end
    end
  end
end
