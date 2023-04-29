# frozen_string_literal: true

module AppStoreConnectApi
  module Utils
    module RelationshipMapper
      class << self
        def expand(relationships)
          relationships.each_with_object({}) do |(relationship_type, resource_id), result|
            data = if resource_id.is_a? Array
                     resource_keys resource_id, resource_type(relationship_type, already_plural: true)
                   else
                     resource_key resource_id, resource_type(relationship_type, already_plural: false)
                   end
            result[relationship_type] = { data: data }
          end
        end

        def resource_keys(ids, resource_type)
          ids.map { |id| resource_key id, resource_type }
        end

        private

        def resource_key(id, resource_type)
          { id: id, type: resource_type }
        end

        def resource_type(relationship_type, already_plural:)
          result = relationship_type.to_s
          result = StringUtils.pluralize(result) unless already_plural
          StringUtils.camelize result
        end
      end
    end
  end
end
