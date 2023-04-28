# frozen_string_literal: true

RSpec.describe AppStoreConnectApi::Client::AppStoreVersionPhasedReleases, :api do
  describe '#create_app_store_version_phased_release' do
    subject { client.create_app_store_version_phased_release({ phased_release_state: 'INACTIVE' }, app_store_version: 'app-store-version-id') }

    it_behaves_like 'a CREATE endpoint', url: 'https://api.appstoreconnect.apple.com/v1/appStoreVersionPhasedReleases',
                                         body: {
                                           data: { attributes: { phasedReleaseState: 'INACTIVE' },
                                                   relationships: { appStoreVersion: { data: { id: 'app-store-version-id', type: 'appStoreVersions' } } },
                                                   type: 'appStoreVersionPhasedReleases' }
                                         }
  end

  describe '#update_app_store_version_phased_release' do
    subject { client.update_app_store_version_phased_release 'app-store-version-phased-release-id', phased_release_state: 'PAUSED' }

    it_behaves_like 'a PATCH endpoint', url: 'https://api.appstoreconnect.apple.com/v1/appStoreVersionPhasedReleases/app-store-version-phased-release-id',
                                        body: {
                                          data: { attributes: { phasedReleaseState: 'PAUSED' },
                                                  id: 'app-store-version-phased-release-id',
                                                  type: 'appStoreVersionPhasedReleases' }
                                        }
  end

  describe '#delete_app_store_version_phased_release' do
    subject { client.delete_app_store_version_phased_release 'app-store-version-phased-release-id' }

    it_behaves_like 'a DELETE endpoint', url: 'https://api.appstoreconnect.apple.com/v1/appStoreVersionPhasedReleases/app-store-version-phased-release-id'
  end
end
