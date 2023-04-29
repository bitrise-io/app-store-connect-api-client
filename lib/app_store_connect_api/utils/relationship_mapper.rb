# frozen_string_literal: true

module AppStoreConnectApi
  module Utils
    module RelationshipMapper
      class << self
        def expand(relationships)
          relationships.each_with_object({}) do |(relationship_type, resource_id), result|
            if resource_id.is_a? Array
              result[relationship_type] = { data: to_resource_keys(resource_id, StringUtils.camelize(relationship_type.to_s)) }
            else
              result[relationship_type] = { data: resource_key(resource_id, relationship_to_resource_type(relationship_type)) }
            end
          end
        end

        def to_resource_keys(ids, resource_type)
          ids.map { |id| resource_key id, resource_type }
        end

        private

        def resource_key(id, resource_type)
          { id: id, type: resource_type }
        end

        def relationship_to_resource_type(name)
          StringUtils.pluralize StringUtils.camelize(name.to_s)
        end
      end
    end
  end
end
