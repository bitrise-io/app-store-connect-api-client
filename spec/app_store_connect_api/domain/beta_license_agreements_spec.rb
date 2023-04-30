# frozen_string_literal: true

RSpec.describe AppStoreConnectApi::Domain::BetaLicenseAgreements, :api do
  describe '#beta_license_agreements' do
    subject { client.beta_license_agreements limit: 10 }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/betaLicenseAgreements',
                                      query_params: { limit: 10 }
  end

  describe '#beta_license_agreement' do
    subject { client.beta_license_agreement 'beta-license-agreement-id', include: 'app' }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/betaLicenseAgreements/beta-license-agreement-id',
                                      query_params: { include: 'app' }
  end

  describe '#update_beta_license_agreement' do
    subject { client.update_beta_license_agreement 'beta-license-agreement-id', agreement_text: 'Text' }

    it_behaves_like 'a PATCH endpoint', url: 'https://api.appstoreconnect.apple.com/v1/betaLicenseAgreements/beta-license-agreement-id',
                                        body: {
                                          data: { attributes: { agreementText: 'Text' },
                                                  id: 'beta-license-agreement-id',
                                                  type: 'betaLicenseAgreements' }
                                        }
  end

  describe '#beta_license_agreement_app' do
    subject { client.beta_license_agreement_app 'beta-license-agreement-id', fields: { apps: 'bundleId' } }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/betaLicenseAgreements/beta-license-agreement-id/app',
                                      query_params: { fields: { apps: 'bundleId' } }
  end
end
