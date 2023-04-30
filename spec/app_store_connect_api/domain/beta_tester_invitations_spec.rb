# frozen_string_literal: true

RSpec.describe AppStoreConnectApi::Domain::BetaTesterInvitations, :api do
  describe '#create_beta_tester_invitation' do
    subject { client.create_beta_tester_invitation app: 'app-id', beta_tester: 'beta-tester-id' }

    it_behaves_like 'a CREATE endpoint', url: 'https://api.appstoreconnect.apple.com/v1/betaTesterInvitations',
                                         body: {
                                           data: { relationships: { app: { data: { id: 'app-id', type: 'apps' } },
                                                                    betaTester: { data: { id: 'beta-tester-id', type: 'betaTesters' } } },
                                                   type: 'betaTesterInvitations' }
                                         }
  end
end
