# frozen_string_literal: true

RSpec.describe AppStoreConnectApi::Domain::BetaAppReviewDetails, :api do
  describe '#beta_app_review_details' do
    subject { client.beta_app_review_details limit: 10 }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/betaAppReviewDetails',
                                      query_params: { limit: 10 }
  end

  describe '#beta_app_review_detail' do
    subject { client.beta_app_review_detail 'beta-app-review-detail-id', include: 'app' }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/betaAppReviewDetails/beta-app-review-detail-id',
                                      query_params: { include: 'app' }
  end

  describe '#update_beta_app_review_detail' do
    subject { client.update_beta_app_review_detail 'beta-app-review-detail-id', notes: 'Text' }

    it_behaves_like 'a PATCH endpoint', url: 'https://api.appstoreconnect.apple.com/v1/betaAppReviewDetails/beta-app-review-detail-id',
                                        body: {
                                          data: { attributes: { notes: 'Text' },
                                                  id: 'beta-app-review-detail-id',
                                                  type: 'betaAppReviewDetails' }
                                        }
  end

  describe '#beta_app_review_detail_app' do
    subject { client.beta_app_review_detail_app 'beta-app-review-detail-id', fields: { apps: 'bundleId' } }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/betaAppReviewDetails/beta-app-review-detail-id/app',
                                      query_params: { fields: { apps: 'bundleId' } }
  end
end
