# frozen_string_literal: true

module AppStoreConnectApi
  module Utils
    module RelationshipMapper
      class << self
        def expand(relationships, type_translations = {})
          relationships.each_with_object({}) do |(relationship_type, resource_id), result|
            result[relationship_type] = { data: expand_relationship(resource_id, relationship_type, type_translations) }
          end
        end

        def resource_keys(ids, resource_type, type_translations = {})
          ids.map { |id| resource_key id, resource_type, type_translations }
        end

        private

        def expand_relationship(resource_id, relationship_type, type_translations)
          return resource_id[:data] if full_format_resource_identifier? resource_id

          if resource_id.is_a? Array
            resource_keys resource_id, to_resource_type(relationship_type, already_plural: true), type_translations
          else
            resource_key resource_id, to_resource_type(relationship_type, already_plural: false), type_translations
          end
        end

        def full_format_resource_identifier?(resource_id)
          resource_id.is_a?(Hash) && resource_id.key?(:data)
        end

        def resource_key(id, resource_type, type_translations = {})
          return id unless id.is_a? String

          { id: id, type: type_translations[resource_type] || type_translations['*'] || resource_type }
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
