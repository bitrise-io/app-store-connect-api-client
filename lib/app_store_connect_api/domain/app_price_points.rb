# frozen_string_literal: true

module AppStoreConnectApi
  module Domain
    module AppPricePoints
      # @see https://developer.apple.com/documentation/appstoreconnectapi/read_app_price_point_information-eg1
      def app_price_point(app_price_point_id, options = {})
        get "/v3/appPricePoints/#{app_price_point_id}", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/list_app_price_point_equalizations
      def app_price_point_equalizations(app_price_point_id, options = {})
        get "/v3/appPricePoints/#{app_price_point_id}/equalizations", options
      end
    end
  end
end
