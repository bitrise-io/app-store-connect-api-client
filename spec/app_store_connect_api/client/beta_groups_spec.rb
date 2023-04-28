# frozen_string_literal: true

RSpec.describe AppStoreConnectApi::Client::BetaGroups, :api do
  describe '#beta_groups' do
    subject { client.beta_groups limit: 10 }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/betaGroups',
                                      query_params: { limit: 10 }
  end

  describe '#beta_group' do
    subject { client.beta_group 'beta-group-id', include: 'betaTesters' }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/betaGroups/beta-group-id',
                                      query_params: { include: 'betaTesters' }
  end

  describe '#create_beta_group' do
    subject { client.create_beta_group({ name: 'Q/A' }, app: 'app-id') }

    it_behaves_like 'a CREATE endpoint', url: 'https://api.appstoreconnect.apple.com/v1/betaGroups',
                                         body: {
                                           data: { attributes: { name: 'Q/A' },
                                                   relationships: { app: { data: { id: 'app-id', type: 'apps' } } },
                                                   type: 'betaGroups' }
                                         }
  end

  describe '#update_beta_group' do
    subject { client.update_beta_group 'beta-group-id', name: 'New name' }

    it_behaves_like 'a PATCH endpoint', url: 'https://api.appstoreconnect.apple.com/v1/betaGroups/beta-group-id',
                                        body: {
                                          data: { attributes: { name: 'New name' },
                                                  id: 'beta-group-id',
                                                  type: 'betaGroups' }
                                        }
  end

  describe '#delete_beta_group' do
    subject { client.delete_beta_group 'beta-group-id' }

    it_behaves_like 'a DELETE endpoint', url: 'https://api.appstoreconnect.apple.com/v1/betaGroups/beta-group-id'
  end

  describe '#beta_group_app' do
    subject { client.beta_group_app 'beta-group-id', fields: { apps: 'name' } }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/betaGroups/beta-group-id/app',
                                      query_params: { fields: { apps: 'name' } }
  end

  describe '#beta_group_beta_testers' do
    subject { client.beta_group_beta_testers 'beta-group-id', limit: 10 }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/betaGroups/beta-group-id/betaTesters',
                                      query_params: { limit: 10 }
  end

  describe '#beta_group_beta_tester_ids' do
    subject { client.beta_group_beta_tester_ids 'beta-group-id', limit: 10 }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/betaGroups/beta-group-id/relationships/betaTesters',
                                      query_params: { limit: 10 }
  end

  describe '#add_beta_group_beta_testers' do
    subject { client.add_beta_group_beta_testers 'beta-group-id', ['tester-id1', 'tester-id2'] }

    it_behaves_like 'a CREATE endpoint', url: 'https://api.appstoreconnect.apple.com/v1/betaGroups/beta-group-id/relationships/betaTesters',
                                         body: {
                                           data: [{ id: 'tester-id1', type: 'betaTesters' },
                                                  { id: 'tester-id2', type: 'betaTesters' }]
                                         }
  end

  describe '#remove_beta_group_beta_testers' do
    subject { client.remove_beta_group_beta_testers 'beta-group-id', ['tester-id1', 'tester-id2'] }

    it_behaves_like 'a DELETE endpoint', url: 'https://api.appstoreconnect.apple.com/v1/betaGroups/beta-group-id/relationships/betaTesters',
                                         body: {
                                           data: [{ id: 'tester-id1', type: 'betaTesters' },
                                                  { id: 'tester-id2', type: 'betaTesters' }]
                                         }
  end

  describe '#beta_group_builds' do
    subject { client.beta_group_builds 'beta-group-id', limit: 10 }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/betaGroups/beta-group-id/builds',
                                      query_params: { limit: 10 }
  end

  describe '#beta_group_build_ids' do
    subject { client.beta_group_build_ids 'beta-group-id', limit: 10 }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/betaGroups/beta-group-id/relationships/builds',
                                      query_params: { limit: 10 }
  end

  describe '#add_beta_group_builds' do
    subject { client.add_beta_group_builds 'beta-group-id', ['build-id1', 'build-id2'] }

    it_behaves_like 'a CREATE endpoint', url: 'https://api.appstoreconnect.apple.com/v1/betaGroups/beta-group-id/relationships/builds',
                                         body: {
                                           data: [{ id: 'build-id1', type: 'builds' },
                                                  { id: 'build-id2', type: 'builds' }]
                                         }
  end

  describe '#remove_beta_group_builds' do
    subject { client.remove_beta_group_builds 'beta-group-id', ['build-id1', 'build-id2'] }

    it_behaves_like 'a DELETE endpoint', url: 'https://api.appstoreconnect.apple.com/v1/betaGroups/beta-group-id/relationships/builds',
                                         body: {
                                           data: [{ id: 'build-id1', type: 'builds' },
                                                  { id: 'build-id2', type: 'builds' }]
                                         }
  end
end
