# frozen_string_literal: true

RSpec.describe AppStoreConnectApi::Domain::BuildBetaNotifications, :api do
  describe '#create_build_beta_notification' do
    subject { client.create_build_beta_notification build: 'build-id' }

    it_behaves_like 'a CREATE endpoint', url: 'https://api.appstoreconnect.apple.com/v1/buildBetaNotifications',
                                         body: {
                                           data: { relationships: { build: { data: { id: 'build-id', type: 'builds' } } },
                                                   type: 'buildBetaNotifications' }
                                         }
  end
end
