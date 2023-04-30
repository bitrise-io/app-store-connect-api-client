# frozen_string_literal: true

RSpec.describe AppStoreConnectApi::Domain::BuildBetaDetails, :api do
  describe '#build_beta_details' do
    subject { client.build_beta_details limit: 10 }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/buildBetaDetails',
                                      query_params: { limit: 10 }
  end

  describe '#build_beta_detail' do
    subject { client.build_beta_detail 'build-beta-detail-id', include: 'build' }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/buildBetaDetails/build-beta-detail-id',
                                      query_params: { include: 'build' }
  end

  describe '#update_build_beta_detail' do
    subject { client.update_build_beta_detail 'build-beta-detail-id', auto_notify_enabled: true }

    it_behaves_like 'a PATCH endpoint', url: 'https://api.appstoreconnect.apple.com/v1/buildBetaDetails/build-beta-detail-id',
                                        body: {
                                          data: { attributes: { autoNotifyEnabled: true },
                                                  id: 'build-beta-detail-id',
                                                  type: 'buildBetaDetails' }
                                        }
  end

  describe '#build_beta_detail_build' do
    subject { client.build_beta_detail_build 'build-beta-detail-id', fields: { builds: 'version' } }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/buildBetaDetails/build-beta-detail-id/build',
                                      query_params: { fields: { builds: 'version' } }
  end
end
