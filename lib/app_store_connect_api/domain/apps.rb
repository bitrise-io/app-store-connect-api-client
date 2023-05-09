# frozen_string_literal: true

module AppStoreConnectApi
  module Domain
    module Apps
      # @see https://developer.apple.com/documentation/appstoreconnectapi/list_apps
      def apps(options = {})
        get '/v1/apps', options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/read_app_information
      def app(app_id, options = {})
        get "/v1/apps/#{app_id}", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/modify_an_app
      def update_app(app_id, attributes = {}, app_price_ids = [])
        patch "/v1/apps/#{app_id}", data: { attributes: attributes,
                                            id: app_id,
                                            type: 'apps' },
                                    included: Utils::RelationshipMapper.resource_keys(app_price_ids, 'appPrices')
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/list_all_beta_groups_for_an_app
      def app_beta_groups(app_id, options = {})
        get "/v1/apps/#{app_id}/betaGroups", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/remove_specified_beta_testers_from_all_groups_and_builds_of_an_app
      def remove_app_beta_testers(app_id, beta_tester_ids)
        delete "/v1/apps/#{app_id}/relationships/betaTesters", data: Utils::RelationshipMapper.resource_keys(beta_tester_ids, 'betaTesters')
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/read_the_beta_app_review_details_resource_of_an_app
      def app_beta_app_review_detail(app_id, options = {})
        get "/v1/apps/#{app_id}/betaAppReviewDetail", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/read_the_beta_license_agreement_of_an_app
      def app_beta_license_agreement(app_id, options = {})
        get "/v1/apps/#{app_id}/betaLicenseAgreement", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/list_all_beta_app_localizations_of_an_app
      def app_beta_app_localizations(app_id, options = {})
        get "/v1/apps/#{app_id}/betaAppLocalizations", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/list_all_builds_of_an_app
      def app_builds(app_id, options = {})
        get "/v1/apps/#{app_id}/builds", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/list_all_prerelease_versions_for_an_app
      def app_prerelease_versions(app_id, options = {})
        get "/v1/apps/#{app_id}/preReleaseVersions", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/list_all_app_clips_for_an_app
      def app_app_clips(app_id, options = {})
        get "/v1/apps/#{app_id}/appClips", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/list_all_price_points_for_an_app
      def app_app_price_points(app_id, options = {})
        get "/v1/apps/#{app_id}/appPricePoints", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/list_all_app_store_versions_for_an_app
      def app_app_store_versions(app_id, options = {})
        get "/v1/apps/#{app_id}/appStoreVersions", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/list_all_app_infos_for_an_app
      def app_app_infos(app_id, options = {})
        get "/v1/apps/#{app_id}/appInfos", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/read_the_pre-order_information_of_an_app
      def app_pre_order(app_id, options = {})
        get "/v1/apps/#{app_id}/preOrder", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/read_the_end_user_license_agreement_information_of_an_app
      def app_end_user_license_agreement(app_id, options = {})
        get "/v1/apps/#{app_id}/endUserLicenseAgreement", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/list_all_custom_product_pages_for_an_app
      def app_app_custom_product_pages(app_id, options = {})
        get "/v1/apps/#{app_id}/appCustomProductPages", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/list_all_in-app_purchases_for_an_app
      def app_in_app_purchases(app_id, options = {})
        get "/v1/apps/#{app_id}/inAppPurchasesV2", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/list_all_promoted_purchases_for_an_app
      def app_promoted_purchases(app_id, options = {})
        get "/v1/apps/#{app_id}/promotedPurchases", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/get_review_submissions_for_an_app
      def app_review_submissions(app_id, options = {})
        get "/v1/apps/#{app_id}/reviewSubmissions", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/list_all_customer_reviews_for_an_app
      def app_customer_reviews(app_id, options = {})
        get "/v1/apps/#{app_id}/customerReviews", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/read_price_schedule_information_for_an_app
      def app_app_price_schedule(app_id, options = {})
        get "/v1/apps/#{app_id}/appPriceSchedule", options
      end
    end
  end
end
