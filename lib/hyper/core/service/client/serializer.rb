module Hyper
  module Core
    module Service
      class Serializer
        attr_reader :blob, :key

        def initialize(blob, key)
          @blob = blob
          @key = key
        end

        def run
          object = parsed(blob)
          object = make_indifferent(object)
          get_root(object)
        end

        def parsed(object)
          JSON.parse(object, symbolize_names: true)
        end

        def make_indifferent(object)
          if object.is_a?(Array)
            object.map!(&:with_indifferent_access)
          else
            object.with_indifferent_access
          end
        end

        def get_root(object)
          if object.is_a?(Array)
            object.map { |obj| root_object(obj) }
          else
            root_object(object)
          end
        end

        def root_object(object)
          object = object.except(:meta)
          if object.keys.length == 1
            if object.key?(key)
              object.fetch(key)
            elsif object.key?(key.singularize)
              object.fetch(key.singularize)
            end
          else
            object
          end
        end
      end
    end
  end
end
