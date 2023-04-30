# frozen_string_literal: true

RSpec.describe AppStoreConnectApi::Domain::BundleIdCapabilities, :api do
  describe '#create_bundle_id_capability' do
    subject { client.create_bundle_id_capability({ capability_type: 'ICLOUD' }, bundle_id: 'bundle-id-id') }

    it_behaves_like 'a POST endpoint', url: 'https://api.appstoreconnect.apple.com/v1/bundleIdCapabilities',
                                       body: {
                                         data: { attributes: { capabilityType: 'ICLOUD' },
                                                 relationships: { bundleId: { data: { id: 'bundle-id-id', type: 'bundleIds' } } },
                                                 type: 'bundleIdCapabilities' }
                                       }
  end

  describe '#update_bundle_id_capability' do
    subject { client.update_bundle_id_capability 'bundle-id-capability-id', capability_type: 'ICLOUD', settings: [{visible: true}] }

    it_behaves_like 'a PATCH endpoint', url: 'https://api.appstoreconnect.apple.com/v1/bundleIdCapabilities/bundle-id-capability-id',
                                        body: {
                                          data: { attributes: { capabilityType: 'ICLOUD', settings: [{visible: true}] },
                                                  id: 'bundle-id-capability-id',
                                                  type: 'bundleIdCapabilities' }
                                        }
  end

  describe '#delete_bundle_id_capability' do
    subject { client.delete_bundle_id_capability 'bundle-id-capability-id' }

    it_behaves_like 'a DELETE endpoint', url: 'https://api.appstoreconnect.apple.com/v1/bundleIdCapabilities/bundle-id-capability-id'
  end
end
