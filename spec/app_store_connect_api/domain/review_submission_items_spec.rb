# frozen_string_literal: true

RSpec.describe AppStoreConnectApi::Domain::ReviewSubmissionItems, :api do
  describe '#create_review_submission_item' do
    subject { client.create_review_submission_item review_submission: 'review-submission-id' }

    it_behaves_like 'a CREATE endpoint', url: 'https://api.appstoreconnect.apple.com/v1/reviewSubmissionItems',
                                         body: {
                                           data: { relationships: { reviewSubmission: { data: { id: 'review-submission-id', type: 'reviewSubmissions' } } },
                                                   type: 'reviewSubmissionItems' }
                                         }
  end

  describe '#update_review_submission_item' do
    subject { client.update_review_submission_item 'review-submission-item-id', removed: true }

    it_behaves_like 'a PATCH endpoint', url: 'https://api.appstoreconnect.apple.com/v1/reviewSubmissionItems/review-submission-item-id',
                                        body: {
                                          data: { attributes: { removed: true },
                                                  id: 'review-submission-item-id',
                                                  type: 'reviewSubmissionItems' }
                                        }
  end

  describe '#delete_review_submission_item' do
    subject { client.delete_review_submission_item 'review-submission-item-id' }

    it_behaves_like 'a DELETE endpoint', url: 'https://api.appstoreconnect.apple.com/v1/reviewSubmissionItems/review-submission-item-id'
  end
end
