# frozen_string_literal: true

RSpec.describe AppStoreConnectApi::Domain::Users, :api do
  describe '#users' do
    subject { client.users limit: 10 }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/users',
                                      query_params: { limit: 10 }
  end

  describe '#user' do
    subject { client.user 'user-id', include: 'visibleApps' }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/users/user-id',
                                      query_params: { include: 'visibleApps' }
  end

  describe '#update_user' do
    subject { client.update_user('user-id', { roles: ['ADMIN'] }, visible_apps: ['app-id']) }

    it_behaves_like 'a PATCH endpoint', url: 'https://api.appstoreconnect.apple.com/v1/users/user-id',
                                        body: {
                                          data: { attributes: { roles: ['ADMIN'] },
                                                  relationships: { visibleApps: { data: [{ id: 'app-id', type: 'apps' }] } },
                                                  id: 'user-id',
                                                  type: 'users' }
                                        }
  end

  describe '#delete_user' do
    subject { client.delete_user 'user-id' }

    it_behaves_like 'a DELETE endpoint', url: 'https://api.appstoreconnect.apple.com/v1/users/user-id'
  end

  describe '#user_visible_apps' do
    subject { client.user_visible_apps 'user-id', limit: 10 }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/users/user-id/visibleApps',
                                      query_params: { limit: 10 }
  end

  describe '#user_visible_app_ids' do
    subject { client.user_visible_app_ids 'user-id', limit: 10 }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/users/user-id/relationships/visibleApps',
                                      query_params: { limit: 10 }
  end

  describe '#add_user_visible_apps' do
    subject { client.add_user_visible_apps 'user-id', ['app-id1', 'app-id2'] }

    it_behaves_like 'a POST endpoint', url: 'https://api.appstoreconnect.apple.com/v1/users/user-id/relationships/visibleApps',
                                       body: {
                                         data: [{ id: 'app-id1', type: 'apps' },
                                                { id: 'app-id2', type: 'apps' }]
                                       }
  end

  describe '#replace_user_visible_apps' do
    subject { client.replace_user_visible_apps 'user-id', ['app-id1', 'app-id2'] }

    it_behaves_like 'a PATCH endpoint', url: 'https://api.appstoreconnect.apple.com/v1/users/user-id/relationships/visibleApps',
                                        body: {
                                          data: [{ id: 'app-id1', type: 'apps' },
                                                 { id: 'app-id2', type: 'apps' }]
                                        }
  end

  describe '#remove_user_visible_apps' do
    subject { client.remove_user_visible_apps 'user-id', ['app-id1', 'app-id2'] }

    it_behaves_like 'a DELETE endpoint', url: 'https://api.appstoreconnect.apple.com/v1/users/user-id/relationships/visibleApps',
                                         body: {
                                           data: [{ id: 'app-id1', type: 'apps' },
                                                  { id: 'app-id2', type: 'apps' }]
                                         }
  end
end
