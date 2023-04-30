# frozen_string_literal: true

RSpec.describe AppStoreConnectApi::Domain::BetaAppLocalizations, :api do
  describe '#beta_app_localizations' do
    subject { client.beta_app_localizations limit: 10 }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/betaAppLocalizations',
                                      query_params: { limit: 10 }
  end

  describe '#beta_app_localization' do
    subject { client.beta_app_localization 'beta-app-localization-id', include: 'app' }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/betaAppLocalizations/beta-app-localization-id',
                                      query_params: { include: 'app' }
  end

  describe '#create_beta_app_localization' do
    subject { client.create_beta_app_localization({ locale: 'en-US', description: 'Description' }, app: 'app-id') }

    it_behaves_like 'a CREATE endpoint', url: 'https://api.appstoreconnect.apple.com/v1/betaAppLocalizations',
                                         body: {
                                           data: { attributes: { locale: 'en-US', description: 'Description' },
                                                   relationships: { app: { data: { id: 'app-id', type: 'apps' } } },
                                                   type: 'betaAppLocalizations' }
                                         }
  end

  describe '#update_beta_app_localization' do
    subject { client.update_beta_app_localization 'beta-app-localization-id', description: 'Description' }

    it_behaves_like 'a PATCH endpoint', url: 'https://api.appstoreconnect.apple.com/v1/betaAppLocalizations/beta-app-localization-id',
                                        body: {
                                          data: { attributes: { description: 'Description' },
                                                  id: 'beta-app-localization-id',
                                                  type: 'betaAppLocalizations' }
                                        }
  end

  describe '#delete_beta_app_localization' do
    subject { client.delete_beta_app_localization 'beta-app-localization-id' }

    it_behaves_like 'a DELETE endpoint', url: 'https://api.appstoreconnect.apple.com/v1/betaAppLocalizations/beta-app-localization-id'
  end

  describe '#beta_app_localization_app' do
    subject { client.beta_app_localization_app 'beta-app-localization-id', fields: { apps: 'bundleId' } }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/betaAppLocalizations/beta-app-localization-id/app',
                                      query_params: { fields: { apps: 'bundleId' } }
  end
end
