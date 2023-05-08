# frozen_string_literal: true

module AppStoreConnectApi
  module Domain
    module AppInfos
      # @see https://developer.apple.com/documentation/appstoreconnectapi/read_app_info_information
      def app_info(app_info_id, options = {})
        get "/v1/appInfos/#{app_info_id}", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/modify_an_app_info
      def update_app_info(app_info_id, relationships)
        patch "/v1/appInfos/#{app_info_id}", data: { relationships: Utils::RelationshipMapper.expand(relationships, '*' => 'appCategories'),
                                                     id: app_info_id,
                                                     type: 'appInfos' }
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/list_all_app_info_localizations_for_an_app_info
      def app_info_localizations(app_info_id, options = {})
        get "/v1/appInfos/#{app_info_id}/appInfoLocalizations", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/get_v1_appinfos_id_ageratingdeclaration
      def app_info_age_rating_declaration(app_info_id, options = {})
        get "/v1/appInfos/#{app_info_id}/ageRatingDeclaration", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/read_the_secondary_category_information_of_an_app_info
      def app_info_primary_category(app_info_id, options = {})
        get "/v1/appInfos/#{app_info_id}/primaryCategory", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/read_the_primary_subcategory_one_information_of_an_app_info
      def app_info_primary_subcategory_one(app_info_id, options = {})
        get "/v1/appInfos/#{app_info_id}/primarySubcategoryOne", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/read_the_primary_subcategory_two_information_of_an_app_info
      def app_info_primary_subcategory_two(app_info_id, options = {})
        get "/v1/appInfos/#{app_info_id}/primarySubcategoryTwo", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/read_the_secondary_category_information_of_an_app_info
      def app_info_secondary_category(app_info_id, options = {})
        get "/v1/appInfos/#{app_info_id}/secondaryCategory", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/read_the_secondary_subcategory_one_information_of_an_app_info
      def app_info_secondary_subcategory_one(app_info_id, options = {})
        get "/v1/appInfos/#{app_info_id}/secondarySubcategoryOne", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/read_the_secondary_subcategory_two_information_of_an_app_info
      def app_info_secondary_subcategory_two(app_info_id, options = {})
        get "/v1/appInfos/#{app_info_id}/secondarySubcategoryTwo", options
      end
    end
  end
end
