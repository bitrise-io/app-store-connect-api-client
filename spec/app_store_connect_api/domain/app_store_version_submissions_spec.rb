# frozen_string_literal: true

RSpec.describe AppStoreConnectApi::Domain::AppStoreVersionSubmissions, :api do
  describe '#delete_app_store_version_submission' do
    subject { client.delete_app_store_version_submission 'app-store-version-submission-id' }

    it_behaves_like 'a DELETE endpoint', url: 'https://api.appstoreconnect.apple.com/v1/appStoreVersionSubmissions/app-store-version-submission-id'
  end
end
