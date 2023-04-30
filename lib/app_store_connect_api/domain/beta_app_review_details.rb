# frozen_string_literal: true

module AppStoreConnectApi
  module Domain
    module BetaAppReviewDetails
      # @see https://developer.apple.com/documentation/appstoreconnectapi/list_beta_app_review_details
      def beta_app_review_details(options = {})
        get '/v1/betaAppReviewDetails', options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/read_beta_app_review_detail_information
      def beta_app_review_detail(beta_app_review_detail_id, options = {})
        get "/v1/betaAppReviewDetails/#{beta_app_review_detail_id}", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/modify_a_beta_app_review_detail
      def update_beta_app_review_detail(beta_app_review_detail_id, attributes)
        patch "/v1/betaAppReviewDetails/#{beta_app_review_detail_id}", data: { attributes: attributes,
                                                                              id: beta_app_review_detail_id,
                                                                              type: 'betaAppReviewDetails' }
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/read_the_app_information_of_a_beta_app_review_detail
      def beta_app_review_detail_app(beta_app_review_detail_id, options = {})
        get "/v1/betaAppReviewDetails/#{beta_app_review_detail_id}/app", options
      end
    end
  end
end
