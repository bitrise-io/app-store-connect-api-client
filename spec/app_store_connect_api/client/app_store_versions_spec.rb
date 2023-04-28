# frozen_string_literal: true

RSpec.describe AppStoreConnectApi::Client::AppStoreVersions, :api do
  describe '#app_store_version' do
    subject { client.app_store_version 'app-store-version-id', include: 'build' }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/appStoreVersions/app-store-version-id',
                                      query_params: { include: 'build' }
  end

  describe '#create_app_store_version' do
    subject { client.create_app_store_version({ version_string: '1.2' }, app: 'app-id') }

    it_behaves_like 'a CREATE endpoint', url: 'https://api.appstoreconnect.apple.com/v1/appStoreVersions',
                                         body: {
                                           data: { attributes: { versionString: '1.2' },
                                                   relationships: { app: { data: { id: 'app-id', type: 'apps' } } },
                                                   type: 'appStoreVersions' }
                                         }
  end

  describe '#update_app_store_version' do
    subject { client.update_app_store_version 'app-store-version-id', { version_string: '1.3' }, build: 'build-id' }

    it_behaves_like 'a PATCH endpoint', url: 'https://api.appstoreconnect.apple.com/v1/appStoreVersions/app-store-version-id',
                                        body: {
                                          data: { attributes: { versionString: '1.3' },
                                                  relationships: { build: { data: { id: 'build-id', type: 'builds' } } },
                                                  id: 'app-store-version-id',
                                                  type: 'appStoreVersions' }
                                        }
  end

  describe '#delete_app_store_version' do
    subject { client.delete_app_store_version 'app-store-version-id' }

    it_behaves_like 'a DELETE endpoint', url: 'https://api.appstoreconnect.apple.com/v1/appStoreVersions/app-store-version-id'
  end

  describe '#app_store_version_build' do
    subject { client.app_store_version_build 'app-store-version-id', fields: { builds: 'app' } }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/appStoreVersions/app-store-version-id/build',
                                      query_params: { fields: { builds: 'app' } }
  end

  describe '#app_store_version_build_id' do
    subject { client.app_store_version_build_id 'app-store-version-id' }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/appStoreVersions/app-store-version-id/relationships/build'
  end

  describe '#update_app_store_version_build' do
    subject { client.update_app_store_version_build 'app-store-version-id', 'build-id' }

    it_behaves_like 'a PATCH endpoint', url: 'https://api.appstoreconnect.apple.com/v1/appStoreVersions/app-store-version-id/relationships/build',
                                        body: {
                                          data: { id: 'build-id',
                                                  type: 'builds' }
                                        }
  end

  describe '#app_store_version_app_store_version_localizations' do
    subject { client.app_store_version_app_store_version_localizations 'app-store-version-id', limit: 10 }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/appStoreVersions/app-store-version-id/appStoreVersionLocalizations',
                                      query_params: { limit: 10 }
  end
end
