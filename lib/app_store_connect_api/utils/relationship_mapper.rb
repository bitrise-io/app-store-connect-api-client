# frozen_string_literal: true

module AppStoreConnectApi
  module Utils
    module RelationshipMapper
      class << self
        def expand(relationships, type_translations = {})
          relationships.each_with_object({}) do |(relationship_type, resource_id), result|
            data = if resource_id.is_a? Array
                     resource_keys resource_id, to_resource_type(relationship_type, already_plural: true), type_translations
                   else
                     resource_key resource_id, to_resource_type(relationship_type, already_plural: false), type_translations
                   end
            result[relationship_type] = { data: data }
          end
        end

        def resource_keys(ids, resource_type, type_translations = {})
          ids.map { |id| resource_key id, resource_type, type_translations }
        end

        private

        def resource_key(id, resource_type, type_translations = {})
          { id: id, type: type_translations[resource_type] || resource_type }
        end

        def to_resource_type(relationship_type, already_plural:)
          result = relationship_type.to_s
          result = StringUtils.pluralize(result) unless already_plural
          StringUtils.camelize result
        end
      end
    end
  end
end
