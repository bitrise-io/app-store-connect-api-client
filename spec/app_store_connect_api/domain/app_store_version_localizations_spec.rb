# frozen_string_literal: true

RSpec.describe AppStoreConnectApi::Domain::AppStoreVersionLocalizations, :api do
  describe '#app_store_version_localization' do
    subject { client.app_store_version_localization 'app-store-version-localization-id', include: 'appStoreVersion' }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/appStoreVersionLocalizations/app-store-version-localization-id',
                                      query_params: { include: 'appStoreVersion' }
  end

  describe '#create_app_store_version_localization' do
    subject { client.create_app_store_version_localization({ description: 'test description' }, app_store_version: 'app-store-version-id') }

    it_behaves_like 'a POST endpoint', url: 'https://api.appstoreconnect.apple.com/v1/appStoreVersionLocalizations',
                                       body: {
                                         data: { attributes: { description: 'test description' },
                                                 relationships: { appStoreVersion: { data: { id: 'app-store-version-id', type: 'appStoreVersions' } } },
                                                 type: 'appStoreVersionLocalizations' }
                                       }
  end

  describe '#update_app_store_version_localization' do
    subject { client.update_app_store_version_localization 'app-store-version-localization-id', description: 'test description' }

    it_behaves_like 'a PATCH endpoint', url: 'https://api.appstoreconnect.apple.com/v1/appStoreVersionLocalizations/app-store-version-localization-id',
                                        body: {
                                          data: { attributes: { description: 'test description' },
                                                  id: 'app-store-version-localization-id',
                                                  type: 'appStoreVersionLocalizations' }
                                        }
  end

  describe '#delete_app_store_version_localization' do
    subject { client.delete_app_store_version_localization 'app-store-version-localization-id' }

    it_behaves_like 'a DELETE endpoint', url: 'https://api.appstoreconnect.apple.com/v1/appStoreVersionLocalizations/app-store-version-localization-id'
  end
end
