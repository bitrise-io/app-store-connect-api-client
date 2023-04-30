# frozen_string_literal: true

RSpec.describe AppStoreConnectApi::Domain::AppStoreVersionReleaseRequests, :api do
  describe '#create_app_store_version_release_request' do
    subject { client.create_app_store_version_release_request app_store_version: 'app-store-version-id' }

    it_behaves_like 'a POST endpoint', url: 'https://api.appstoreconnect.apple.com/v1/appStoreVersionReleaseRequests',
                                       body: {
                                         data: { relationships: { appStoreVersion: { data: { id: 'app-store-version-id', type: 'appStoreVersions' } } },
                                                 type: 'appStoreVersionReleaseRequests' }
                                       }
  end
end
