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

  describe '#app_app_store_versions' do
    subject { client.app_app_store_versions 'app-id', limit: 10 }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/apps/app-id/appStoreVersions',
                                      query_params: { limit: 10 }
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
end
