# frozen_string_literal: true

module AppStoreConnectApi
  module Domain
    module AppAvailabilities
      # @see https://developer.apple.com/documentation/appstoreconnectapi/read_the_availability_for_an_app
      def app_availability(app_availability_id, options = {})
        get "/v1/appAvailabilities/#{app_availability_id}", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/modify_territory_availability_for_an_app
      def create_app_availability(attributes, relationships)
        post '/v1/appAvailabilities', data: { attributes: attributes,
                                              relationships: Utils::RelationshipMapper.expand(relationships, 'availableTerritories' => 'territories'),
                                              type: 'appAvailabilities' }
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/list_territory_availability_for_an_app
      def app_availability_available_territories(app_availability_id, options = {})
        get "/v1/appAvailabilities/#{app_availability_id}/availableTerritories", options
      end
    end
  end
end
