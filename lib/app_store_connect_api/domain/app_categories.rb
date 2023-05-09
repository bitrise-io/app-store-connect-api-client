# frozen_string_literal: true

module AppStoreConnectApi
  module Domain
    module AppCategories
      # @see https://developer.apple.com/documentation/appstoreconnectapi/list_app_categories
      def app_categories(options = {})
        get '/v1/appCategories', options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/read_app_category_information
      def app_category(app_category_id, options = {})
        get "/v1/appCategories/#{app_category_id}", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/list_all_subcategories_for_an_app_category
      def app_category_subcategories(app_category_id, options = {})
        get "/v1/appCategories/#{app_category_id}/subcategories", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/read_the_parent_information_of_an_app_category
      def app_category_parent(app_category_id, options = {})
        get "/v1/appCategories/#{app_category_id}/parent", options
      end
    end
  end
end
