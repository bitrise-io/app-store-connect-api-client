# frozen_string_literal: true

module AppStoreConnectApi
  module Domain
    module ReviewSubmissionItems
      # @see https://developer.apple.com/documentation/appstoreconnectapi/post_v1_reviewsubmissionitems
      def create_review_submission_item(relationships)
        post '/v1/reviewSubmissionItems', data: { relationships: Utils::RelationshipMapper.expand(relationships),
                                                  type: 'reviewSubmissionItems' }
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/patch_v1_reviewsubmissionitems_id
      def update_review_submission_item(review_submission_item_id, attributes)
        patch "/v1/reviewSubmissionItems/#{review_submission_item_id}", data: { attributes: attributes,
                                                                                id: review_submission_item_id,
                                                                                type: 'reviewSubmissionItems' }
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/remove_a_review_submission_item
      def delete_review_submission_item(review_submission_item_id)
        delete "/v1/reviewSubmissionItems/#{review_submission_item_id}"
      end
    end
  end
end
