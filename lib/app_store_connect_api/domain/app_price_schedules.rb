# frozen_string_literal: true

module AppStoreConnectApi
  module Domain
    module AppPriceSchedules
      # @see https://developer.apple.com/documentation/appstoreconnectapi/read_an_app_s_price_schedule_information
      def app_price_schedule(app_price_schedule_id, options = {})
        get "/v1/appPriceSchedules/#{app_price_schedule_id}", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/add_a_scheduled_price_change_to_an_app
      def create_app_price_schedule(relationships, app_price_ids = [], territory_ids = [])
        post '/v1/appPriceSchedules', data: { relationships: Utils::RelationshipMapper.expand(relationships, 'manualPrices' => 'appPrices', 'baseTerritories' => 'territories'),
                                              included: Utils::RelationshipMapper.resource_keys(app_price_ids, 'appPrices') +
                                                        Utils::RelationshipMapper.resource_keys(territory_ids, 'territories'),
                                              type: 'appPriceSchedules' }
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/list_automatically_generated_prices_for_an_app
      def app_price_schedule_automatic_prices(app_price_schedule_id, options = {})
        get "/v1/appPriceSchedules/#{app_price_schedule_id}/automaticPrices", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/list_manually_chosen_prices_for_an_app
      def app_price_schedule_manual_prices(app_price_schedule_id, options = {})
        get "/v1/appPriceSchedules/#{app_price_schedule_id}/manualPrices", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/read_the_base_territory_for_an_app_s_price_schedule
      def app_price_schedule_base_territory(app_price_schedule_id, options = {})
        get "/v1/appPriceSchedules/#{app_price_schedule_id}/baseTerritory", options
      end
    end
  end
end
