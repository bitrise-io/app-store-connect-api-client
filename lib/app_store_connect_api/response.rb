# frozen_string_literal: true

require_relative 'api_error'

module AppStoreConnectApi
  class Response
    def initialize(raw_response, relationships = nil)
      relationships = [] if relationships.nil?

      @raw_response = raw_response
      @relationships = Array(relationships)
    end

    def response
      return if @raw_response.empty?
      raise Error, @raw_response unless @raw_response.is_a? Hash

      if @raw_response.key? :errors
        raise ApiError, @raw_response[:errors]
      elsif @raw_response.key? :data
        process_data_from_response
      end
    end

    private

    def process_data_from_response
      case @raw_response[:data]
      when Array
        @raw_response[:data].map { |item| process_data_item item, @relationships }
      else
        process_data_item @raw_response[:data], @relationships
      end
    end

    def process_data_item(item, relationships = [])
      return item unless item.is_a? Hash

      result = { id: item[:id] }
      result.merge! item[:attributes] unless item[:attributes].nil?
      relationships.each do |relationship|
        process_relationship item, relationship, result
      end
      result
    end

    def process_relationship(item, relationship, data_item)
      related_item = item[:relationships][relationship]
      data_item[:"#{relationship}_total"] = related_item[:meta][:paging][:total] if related_item.dig :meta, :paging
      data_item[relationship] = process_relationship_data related_item[:data]
    end

    def process_relationship_data(relationship_data)
      return relationship_data if relationship_data.blank?

      case relationship_data
      when Array
        relationship_data.map { |relationship_id| related_included_item_for relationship_id }
      else
        related_included_item_for relationship_data
      end
    end

    def related_included_item_for(relationship_id)
      related_item = @raw_response[:included].find { |el| el[:type] == relationship_id[:type] && el[:id] == relationship_id[:id] }
      process_data_item related_item
    end
  end
end