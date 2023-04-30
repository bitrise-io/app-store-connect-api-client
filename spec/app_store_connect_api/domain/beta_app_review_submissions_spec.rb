# frozen_string_literal: true

RSpec.describe AppStoreConnectApi::Domain::BetaAppReviewSubmissions, :api do
  describe '#beta_app_review_submissions' do
    subject { client.beta_app_review_submissions include: 'build' }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/betaAppReviewSubmissions',
                                      query_params: { include: 'build' }
  end

  describe '#beta_app_review_submission' do
    subject { client.beta_app_review_submission 'beta-app-review-submission-id', include: 'build' }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/betaAppReviewSubmissions/beta-app-review-submission-id',
                                      query_params: { include: 'build' }
  end

  describe '#create_beta_app_review_submission' do
    subject { client.create_beta_app_review_submission build: 'build-id' }

    it_behaves_like 'a POST endpoint', url: 'https://api.appstoreconnect.apple.com/v1/betaAppReviewSubmissions',
                                       body: {
                                         data: { relationships: { build: { data: { id: 'build-id', type: 'builds' } } },
                                                 type: 'betaAppReviewSubmissions' }
                                       }
  end

  describe '#beta_app_review_submission_build' do
    subject { client.beta_app_review_submission_build 'beta-app-review-submission-id', fields: { builds: 'version' } }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/betaAppReviewSubmissions/beta-app-review-submission-id/build',
                                      query_params: { fields: { builds: 'version' } }
  end
end
