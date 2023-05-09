# frozen_string_literal: true

RSpec.describe AppStoreConnectApi::Domain::Apps, :api do
  describe '#apps' do
    subject { client.apps limit: 10 }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/apps',
                                      query_params: { limit: 10 }
  end

  describe '#app' do
    subject { client.app 'app-id', include: 'appStoreVersions' }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/apps/app-id',
                                      query_params: { include: 'appStoreVersions' }
  end

  describe '#update_app' do
    subject { client.update_app 'app-id', { primary_locale: 'en-US' }, ['price-id1', 'price-id2'] }

    it_behaves_like 'a PATCH endpoint', url: 'https://api.appstoreconnect.apple.com/v1/apps/app-id',
                                        body: {
                                          data: { attributes: { primaryLocale: 'en-US' },
                                                  id: 'app-id',
                                                  type: 'apps' },
                                          included: [{ id: 'price-id1', type: 'appPrices' },
                                                     { id: 'price-id2', type: 'appPrices' }]
                                        }
  end

  describe '#app_beta_groups' do
    subject { client.app_beta_groups 'app-id', limit: 10 }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/apps/app-id/betaGroups',
                                      query_params: { limit: 10 }
  end

  describe '#remove_app_beta_testers' do
    subject { client.remove_app_beta_testers 'app-id', ['beta-tester-id1', 'beta-tester-id2'] }

    it_behaves_like 'a DELETE endpoint', url: 'https://api.appstoreconnect.apple.com/v1/apps/app-id/relationships/betaTesters',
                                         body: {
                                           data: [{ id: 'beta-tester-id1', type: 'betaTesters' },
                                                  { id: 'beta-tester-id2', type: 'betaTesters' }]
                                         }
  end

  describe '#app_beta_app_review_detail' do
    subject { client.app_beta_app_review_detail 'app-id', fields: { beta_app_review_detail: 'app' } }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/apps/app-id/betaAppReviewDetail',
                                      query_params: { fields: { betaAppReviewDetail: 'app' } }
  end

  describe '#app_beta_license_agreement' do
    subject { client.app_beta_license_agreement 'app-id', fields: { beta_license_agreement: 'app' } }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/apps/app-id/betaLicenseAgreement',
                                      query_params: { fields: { betaLicenseAgreement: 'app' } }
  end

  describe '#app_beta_app_localizations' do
    subject { client.app_beta_app_localizations 'app-id', limit: 10 }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/apps/app-id/betaAppLocalizations',
                                      query_params: { limit: 10 }
  end

  describe '#app_builds' do
    subject { client.app_builds 'app-id', limit: 10 }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/apps/app-id/builds',
                                      query_params: { limit: 10 }
  end

  describe '#app_prerelease_versions' do
    subject { client.app_prerelease_versions 'app-id', limit: 10 }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/apps/app-id/preReleaseVersions',
                                      query_params: { limit: 10 }
  end

  describe '#app_app_clips' do
    subject { client.app_app_clips 'app-id', limit: 10 }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/apps/app-id/appClips',
                                      query_params: { limit: 10 }
  end

  describe '#app_app_price_points' do
    subject { client.app_app_price_points 'app-id', limit: 10 }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/apps/app-id/appPricePoints',
                                      query_params: { limit: 10 }
  end

  describe '#app_app_store_versions' do
    subject { client.app_app_store_versions 'app-id', limit: 10 }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/apps/app-id/appStoreVersions',
                                      query_params: { limit: 10 }
  end

  describe '#app_app_infos' do
    subject { client.app_app_infos 'app-id', limit: 10 }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/apps/app-id/appInfos',
                                      query_params: { limit: 10 }
  end

  describe '#app_pre_order' do
    subject { client.app_pre_order 'app-id', fields: { app_pre_orders: 'app' } }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/apps/app-id/preOrder',
                                      query_params: { fields: { appPreOrders: 'app' } }
  end

  describe '#app_end_user_license_agreement' do
    subject { client.app_end_user_license_agreement 'app-id', fields: { end_user_license_agreements: 'app' } }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/apps/app-id/endUserLicenseAgreement',
                                      query_params: { fields: { endUserLicenseAgreements: 'app' } }
  end

  describe '#app_app_custom_product_pages' do
    subject { client.app_app_custom_product_pages 'app-id', limit: 10 }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/apps/app-id/appCustomProductPages',
                                      query_params: { limit: 10 }
  end

  describe '#app_in_app_purchases' do
    subject { client.app_in_app_purchases 'app-id', limit: 10 }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/apps/app-id/inAppPurchasesV2',
                                      query_params: { limit: 10 }
  end

  describe '#app_promoted_purchases' do
    subject { client.app_promoted_purchases 'app-id', limit: 10 }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/apps/app-id/promotedPurchases',
                                      query_params: { limit: 10 }
  end

  describe '#app_review_submissions' do
    subject { client.app_review_submissions 'app-id', limit: 10 }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/apps/app-id/reviewSubmissions',
                                      query_params: { limit: 10 }
  end

  describe '#app_customer_reviews' do
    subject { client.app_customer_reviews 'app-id', limit: 10 }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/apps/app-id/customerReviews',
                                      query_params: { limit: 10 }
  end

  describe '#app_app_price_schedule' do
    subject { client.app_app_price_schedule 'app-id', include: 'app' }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/apps/app-id/appPriceSchedule',
                                      query_params: { include: 'app' }
  end

  describe '#app_app_availability' do
    subject { client.app_app_availability 'app-id', include: 'app' }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/apps/app-id/appAvailability',
                                      query_params: { include: 'app' }
  end
end
