# frozen_string_literal: true

module AppStoreConnectApi
  module Domain
    module BetaAppReviewSubmissions
      # @see https://developer.apple.com/documentation/appstoreconnectapi/list_beta_app_review_submissions
      def beta_app_review_submissions(options = {})
        get '/v1/betaAppReviewSubmissions', options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/read_beta_app_review_submission_information
      def beta_app_review_submission(beta_app_review_submission_id, options = {})
        get "/v1/betaAppReviewSubmissions/#{beta_app_review_submission_id}", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/submit_an_app_for_beta_review
      def create_beta_app_review_submission(relationships)
        post '/v1/betaAppReviewSubmissions', data: { relationships: Utils::RelationshipMapper.expand(relationships),
                                                     type: 'betaAppReviewSubmissions' }
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/read_the_build_information_of_a_beta_app_review_submission
      def beta_app_review_submission_build(beta_app_review_submission_id, options = {})
        get "/v1/betaAppReviewSubmissions/#{beta_app_review_submission_id}/build", options
      end
    end
  end
end
