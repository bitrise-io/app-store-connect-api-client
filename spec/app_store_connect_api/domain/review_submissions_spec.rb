# frozen_string_literal: true

RSpec.describe AppStoreConnectApi::Domain::ReviewSubmissions, :api do
  describe '#review_submissions' do
    subject { client.review_submissions include: 'items' }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/reviewSubmissions',
                                      query_params: { include: 'items' }
  end

  describe '#review_submission' do
    subject { client.review_submission 'review-submission-id', include: 'items' }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/reviewSubmissions/review-submission-id',
                                      query_params: { include: 'items' }
  end

  describe '#create_review_submission' do
    subject { client.create_review_submission({ platform: 'IOS' }, app: 'app-id') }

    it_behaves_like 'a POST endpoint', url: 'https://api.appstoreconnect.apple.com/v1/reviewSubmissions',
                                       body: {
                                         data: { attributes: { platform: 'IOS' },
                                                 relationships: { app: { data: { id: 'app-id', type: 'apps' } } },
                                                 type: 'reviewSubmissions' }
                                       }
  end

  describe '#update_review_submission' do
    subject { client.update_review_submission 'review-submission-id', submitted: true }

    it_behaves_like 'a PATCH endpoint', url: 'https://api.appstoreconnect.apple.com/v1/reviewSubmissions/review-submission-id',
                                        body: {
                                          data: { attributes: { submitted: true },
                                                  id: 'review-submission-id',
                                                  type: 'reviewSubmissions' }
                                        }
  end

  describe '#review_submission_items' do
    subject { client.review_submission_items 'review-submission-id', limit: 10 }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/reviewSubmissions/review-submission-id/items',
                                      query_params: { limit: 10 }
  end
end
