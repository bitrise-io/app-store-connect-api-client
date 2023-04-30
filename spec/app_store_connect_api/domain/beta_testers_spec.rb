# frozen_string_literal: true

RSpec.describe AppStoreConnectApi::Domain::BetaTesters, :api do
  describe '#beta_testers' do
    subject { client.beta_testers limit: 10 }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/betaTesters',
                                      query_params: { limit: 10 }
  end

  describe '#beta_tester' do
    subject { client.beta_tester 'beta-tester-id', include: 'betaGroups' }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/betaTesters/beta-tester-id',
                                      query_params: { include: 'betaGroups' }
  end

  describe '#create_beta_tester' do
    subject { client.create_beta_tester({ email: 'tester@example.com' }, beta_groups: ['beta-group-id']) }

    it_behaves_like 'a POST endpoint', url: 'https://api.appstoreconnect.apple.com/v1/betaTesters',
                                       body: {
                                         data: { attributes: { email: 'tester@example.com' },
                                                 relationships: { betaGroups: { data: [{ id: 'beta-group-id', type: 'betaGroups' }] } },
                                                 type: 'betaTesters' }
                                       }
  end

  describe '#delete_beta_tester' do
    subject { client.delete_beta_tester 'beta-tester-id' }

    it_behaves_like 'a DELETE endpoint', url: 'https://api.appstoreconnect.apple.com/v1/betaTesters/beta-tester-id'
  end

  describe '#beta_tester_apps' do
    subject { client.beta_tester_apps 'beta-tester-id', limit: 10 }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/betaTesters/beta-tester-id/apps',
                                      query_params: { limit: 10 }
  end

  describe '#beta_tester_app_ids' do
    subject { client.beta_tester_app_ids 'beta-tester-id', limit: 10 }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/betaTesters/beta-tester-id/relationships/apps',
                                      query_params: { limit: 10 }
  end

  describe '#remove_beta_tester_apps' do
    subject { client.remove_beta_tester_apps 'beta-tester-id', ['app-id1', 'app-id2'] }

    it_behaves_like 'a DELETE endpoint', url: 'https://api.appstoreconnect.apple.com/v1/betaTesters/beta-tester-id/relationships/apps',
                                         body: {
                                           data: [{ id: 'app-id1', type: 'apps' },
                                                  { id: 'app-id2', type: 'apps' }]
                                         }
  end

  describe '#beta_tester_beta_groups' do
    subject { client.beta_tester_beta_groups 'beta-tester-id', limit: 10 }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/betaTesters/beta-tester-id/betaGroups',
                                      query_params: { limit: 10 }
  end

  describe '#beta_tester_beta_group_ids' do
    subject { client.beta_tester_beta_group_ids 'beta-tester-id', limit: 10 }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/betaTesters/beta-tester-id/relationships/betaGroups',
                                      query_params: { limit: 10 }
  end

  describe '#add_beta_tester_beta_groups' do
    subject { client.add_beta_tester_beta_groups 'beta-tester-id', ['group-id1', 'group-id2'] }

    it_behaves_like 'a POST endpoint', url: 'https://api.appstoreconnect.apple.com/v1/betaTesters/beta-tester-id/relationships/betaGroups',
                                       body: {
                                         data: [{ id: 'group-id1', type: 'betaGroups' },
                                                { id: 'group-id2', type: 'betaGroups' }]
                                       }
  end

  describe '#remove_beta_tester_beta_groups' do
    subject { client.remove_beta_tester_beta_groups 'beta-tester-id', ['group-id1', 'group-id2'] }

    it_behaves_like 'a DELETE endpoint', url: 'https://api.appstoreconnect.apple.com/v1/betaTesters/beta-tester-id/relationships/betaGroups',
                                         body: {
                                           data: [{ id: 'group-id1', type: 'betaGroups' },
                                                  { id: 'group-id2', type: 'betaGroups' }]
                                         }
  end

  describe '#beta_tester_builds' do
    subject { client.beta_tester_builds 'beta-tester-id', limit: 10 }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/betaTesters/beta-tester-id/builds',
                                      query_params: { limit: 10 }
  end

  describe '#beta_tester_build_ids' do
    subject { client.beta_tester_build_ids 'beta-tester-id', limit: 10 }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/betaTesters/beta-tester-id/relationships/builds',
                                      query_params: { limit: 10 }
  end

  describe '#add_beta_tester_builds' do
    subject { client.add_beta_tester_builds 'beta-tester-id', ['build-id1', 'build-id2'] }

    it_behaves_like 'a POST endpoint', url: 'https://api.appstoreconnect.apple.com/v1/betaTesters/beta-tester-id/relationships/builds',
                                       body: {
                                         data: [{ id: 'build-id1', type: 'builds' },
                                                { id: 'build-id2', type: 'builds' }]
                                       }
  end

  describe '#remove_beta_tester_builds' do
    subject { client.remove_beta_tester_builds 'beta-tester-id', ['build-id1', 'build-id2'] }

    it_behaves_like 'a DELETE endpoint', url: 'https://api.appstoreconnect.apple.com/v1/betaTesters/beta-tester-id/relationships/builds',
                                         body: {
                                           data: [{ id: 'build-id1', type: 'builds' },
                                                  { id: 'build-id2', type: 'builds' }]
                                         }
  end
end
