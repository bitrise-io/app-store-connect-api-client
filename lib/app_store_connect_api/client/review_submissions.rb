# frozen_string_literal: true

module AppStoreConnectApi
  class Client
    module ReviewSubmissions
      # @see https://developer.apple.com/documentation/appstoreconnectapi/list_review_submissions_for_an_app
      def review_submissions(options = {})
        get '/v1/reviewSubmissions', options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/read_review_submission_information
      def review_submission(review_submission_id, options = {})
        get "/v1/reviewSubmissions/#{review_submission_id}", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/create_a_review_submission
      def create_review_submission(attributes, relationships)
        create '/v1/reviewSubmissions', data: { attributes: attributes,
                                                relationships: Utils::RelationshipMapper.expand(relationships),
                                                type: 'reviewSubmissions' }
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/modify_a_review_submission
      def update_review_submission(review_submission_id, attributes)
        patch "/v1/reviewSubmissions/#{review_submission_id}", data: { attributes: attributes,
                                                                       id: review_submission_id,
                                                                       type: 'reviewSubmissions' }
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/list_the_items_in_a_review_submission
      def review_submission_items(review_submission_id, options = {})
        get "/v1/reviewSubmissions/#{review_submission_id}/items", options
      end
    end
  end
end
