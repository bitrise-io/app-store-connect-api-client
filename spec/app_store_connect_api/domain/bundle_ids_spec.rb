# frozen_string_literal: true

RSpec.describe AppStoreConnectApi::Domain::BundleIds, :api do
  describe '#bundle_ids' do
    subject { client.bundle_ids limit: 10 }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/bundleIds',
                                      query_params: { limit: 10 }
  end

  describe '#bundle_id' do
    subject { client.bundle_id 'bundle-id-id', include: 'app' }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/bundleIds/bundle-id-id',
                                      query_params: { include: 'app' }
  end

  describe '#create_bundle_id' do
    subject { client.create_bundle_id identifier: 'id.bundle', name: 'Name', platform: 'IOS' }

    it_behaves_like 'a POST endpoint', url: 'https://api.appstoreconnect.apple.com/v1/bundleIds',
                                       body: {
                                         data: { attributes: { identifier: 'id.bundle', name: 'Name', platform: 'IOS' },
                                                 type: 'bundleIds' }
                                       }
  end

  describe '#update_bundle_id' do
    subject { client.update_bundle_id 'bundle-id-id', name: 'New name' }

    it_behaves_like 'a PATCH endpoint', url: 'https://api.appstoreconnect.apple.com/v1/bundleIds/bundle-id-id',
                                        body: {
                                          data: { attributes: { name: 'New name' },
                                                  id: 'bundle-id-id',
                                                  type: 'bundleIds' }
                                        }
  end

  describe '#delete_bundle_id' do
    subject { client.delete_bundle_id 'bundle-id-id' }

    it_behaves_like 'a DELETE endpoint', url: 'https://api.appstoreconnect.apple.com/v1/bundleIds/bundle-id-id'
  end

  describe '#bundle_id_app' do
    subject { client.bundle_id_app 'bundle-id-id', fields: { apps: 'sku' } }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/bundleIds/bundle-id-id/app',
                                      query_params: { fields: { apps: 'sku' } }
  end

  describe '#bundle_id_bundle_id_capabilities' do
    subject { client.bundle_id_bundle_id_capabilities 'bundle-id-id', limit: 10 }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/bundleIds/bundle-id-id/bundleIdCapabilities',
                                      query_params: { limit: 10 }
  end

  describe '#bundle_id_profiles' do
    subject { client.bundle_id_profiles 'bundle-id-id', limit: 10 }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/bundleIds/bundle-id-id/profiles',
                                      query_params: { limit: 10 }
  end
end
