# frozen_string_literal: true

module AppStoreConnectApi
  module Domain
    module AppStoreVersions
      # @see https://developer.apple.com/documentation/appstoreconnectapi/read_app_store_version_information
      def app_store_version(app_store_version_id, options = {})
        get "/v1/appStoreVersions/#{app_store_version_id}", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/create_an_app_store_version
      def create_app_store_version(attributes, relationships)
        post '/v1/appStoreVersions', data: { attributes: attributes,
                                             relationships: Utils::RelationshipMapper.expand(relationships),
                                             type: 'appStoreVersions' }
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/modify_an_app_store_version
      def update_app_store_version(app_store_version_id, attributes = {}, relationships = {})
        patch "/v1/appStoreVersions/#{app_store_version_id}", data: { attributes: attributes,
                                                                      relationships: Utils::RelationshipMapper.expand(relationships),
                                                                      id: app_store_version_id,
                                                                      type: 'appStoreVersions' }
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/delete_an_app_store_version
      def delete_app_store_version(app_store_version_id)
        delete "/v1/appStoreVersions/#{app_store_version_id}"
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/read_the_build_information_of_an_app_store_version
      def app_store_version_build(app_store_version_id, options = {})
        get "/v1/appStoreVersions/#{app_store_version_id}/build", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/get_the_build_id_for_an_app_store_version
      def app_store_version_build_id(app_store_version_id)
        get "/v1/appStoreVersions/#{app_store_version_id}/relationships/build"
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/modify_the_build_for_an_app_store_version
      def update_app_store_version_build(app_store_version_id, build_id)
        patch "/v1/appStoreVersions/#{app_store_version_id}/relationships/build", data: { id: build_id, type: 'builds' }
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/get_v1_appstoreversions_id_appstoreversionexperiments
      def app_store_version_app_store_version_experiments(app_store_version_id, options = {})
        get "/v1/appStoreVersions/#{app_store_version_id}/appStoreVersionExperiments", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/list_all_app_store_version_localizations_for_an_app_store_version
      def app_store_version_app_store_version_localizations(app_store_version_id, options = {})
        get "/v1/appStoreVersions/#{app_store_version_id}/appStoreVersionLocalizations", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/read_the_app_store_version_phased_release_information_of_an_app_store_version
      def app_store_version_app_store_version_phased_release(app_store_version_id, options = {})
        get "/v1/appStoreVersions/#{app_store_version_id}/appStoreVersionPhasedRelease", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/read_the_app_store_review_details_resource_information_of_an_app_store_version
      def app_store_version_app_store_review_detail(app_store_version_id, options = {})
        get "/v1/appStoreVersions/#{app_store_version_id}/appStoreReviewDetail", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/read_the_routing_app_coverage_information_of_an_app_store_version
      def app_store_version_routing_app_coverage(app_store_version_id, options = {})
        get "/v1/appStoreVersions/#{app_store_version_id}/routingAppCoverage", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/list_all_customer_reviews_for_an_app_store_version
      def app_store_version_customer_reviews(app_store_version_id, options = {})
        get "/v1/appStoreVersions/#{app_store_version_id}/customerReviews", options
      end
    end
  end
end
