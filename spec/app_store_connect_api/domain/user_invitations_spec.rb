# frozen_string_literal: true

RSpec.describe AppStoreConnectApi::Domain::UserInvitations, :api do
  describe '#user_invitations' do
    subject { client.user_invitations limit: 10 }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/userInvitations',
                                      query_params: { limit: 10 }
  end

  describe '#user_invitation' do
    subject { client.user_invitation 'user-invitation-id', fields: { user_invitations: 'email' } }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/userInvitations/user-invitation-id',
                                      query_params: { fields: { userInvitations: 'email' } }
  end

  describe '#create_user_invitation' do
    subject { client.create_user_invitation({ email: 'dev@example.com' }, visible_apps: ['app-id']) }

    it_behaves_like 'a CREATE endpoint', url: 'https://api.appstoreconnect.apple.com/v1/userInvitations',
                                         body: {
                                           data: { attributes: { email: 'dev@example.com' },
                                                   relationships: { visibleApps: { data: [{ id: 'app-id', type: 'apps' }] } },
                                                   type: 'user_invitations' }
                                         }
  end

  describe '#delete_user_invitation' do
    subject { client.delete_user_invitation 'user-invitation-id' }

    it_behaves_like 'a DELETE endpoint', url: 'https://api.appstoreconnect.apple.com/v1/userInvitations/user-invitation-id'
  end

  describe '#user_invitation_visible_apps' do
    subject { client.user_invitation_visible_apps 'user-invitation-id', limit: 10 }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/userInvitations/user-invitation-id/visibleApps',
                                      query_params: { limit: 10 }
  end
end
