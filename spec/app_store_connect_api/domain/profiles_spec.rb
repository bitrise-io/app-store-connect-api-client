# frozen_string_literal: true

RSpec.describe AppStoreConnectApi::Domain::Profiles, :api do
  describe '#profiles' do
    subject { client.profiles limit: 10 }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/profiles',
                                      query_params: { limit: 10 }
  end

  describe '#profile' do
    subject { client.profile 'profile-id', include: 'devices' }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/profiles/profile-id',
                                      query_params: { include: 'devices' }
  end

  describe '#create_profile' do
    subject { client.create_profile({ name: 'Name', profile_type: 'IOS_APP_DEVELOPMENT' }, bundle_id: 'bundle-id-id', certificates: ['certificate-id']) }

    it_behaves_like 'a CREATE endpoint', url: 'https://api.appstoreconnect.apple.com/v1/profiles',
                                         body: {
                                           data: { attributes: { name: 'Name', profileType: 'IOS_APP_DEVELOPMENT' },
                                                   relationships: { bundleId: { data: { id: 'bundle-id-id', type: 'bundleIds' } },
                                                                    certificates: { data: [{ id: 'certificate-id', type: 'certificates' }] } },
                                                   type: 'profiles' }
                                         }
  end

  describe '#delete_profile' do
    subject { client.delete_profile 'profile-id' }

    it_behaves_like 'a DELETE endpoint', url: 'https://api.appstoreconnect.apple.com/v1/profiles/profile-id'
  end

  describe '#profile_bundle_id' do
    subject { client.profile_bundle_id 'profile-id', fields: { bundle_ids: 'name' } }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/profiles/profile-id/bundleId',
                    query_params: { fields: { bundleIds: 'name' } }
  end

  describe '#profile_certificates' do
    subject { client.profile_certificates 'profile-id', limit: 10 }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/profiles/profile-id/certificates',
                    query_params: { limit: 10 }
  end

  describe '#profile_devices' do
    subject { client.profile_devices 'profile-id', limit: 10 }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/profiles/profile-id/devices',
                    query_params: { limit: 10 }
  end
end
