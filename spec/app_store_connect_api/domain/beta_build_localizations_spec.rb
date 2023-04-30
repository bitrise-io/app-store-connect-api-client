# frozen_string_literal: true

RSpec.describe AppStoreConnectApi::Domain::BetaBuildLocalizations, :api do
  describe '#beta_build_localizations' do
    subject { client.beta_build_localizations include: 'build' }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/betaBuildLocalizations',
                                      query_params: { include: 'build' }
  end

  describe '#beta_build_localization' do
    subject { client.beta_build_localization 'beta-build-localization-id', include: 'build' }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/betaBuildLocalizations/beta-build-localization-id',
                                      query_params: { include: 'build' }
  end

  describe '#create_beta_build_localization' do
    subject { client.create_beta_build_localization({ locale: 'en-US', whats_new: 'News' }, build: 'build-id') }

    it_behaves_like 'a POST endpoint', url: 'https://api.appstoreconnect.apple.com/v1/betaBuildLocalizations',
                                       body: {
                                         data: { attributes: { locale: 'en-US', whatsNew: 'News' },
                                                 relationships: { build: { data: { id: 'build-id', type: 'builds' } } },
                                                 type: 'betaBuildLocalizations' }
                                       }
  end

  describe '#update_beta_build_localization' do
    subject { client.update_beta_build_localization 'beta-build-localization-id', whats_new: 'News' }

    it_behaves_like 'a PATCH endpoint', url: 'https://api.appstoreconnect.apple.com/v1/betaBuildLocalizations/beta-build-localization-id',
                                        body: {
                                          data: { attributes: { whatsNew: 'News' },
                                                  id: 'beta-build-localization-id',
                                                  type: 'betaBuildLocalizations' }
                                        }
  end

  describe '#delete_beta_build_localization' do
    subject { client.delete_beta_build_localization 'beta-build-localization-id' }

    it_behaves_like 'a DELETE endpoint', url: 'https://api.appstoreconnect.apple.com/v1/betaBuildLocalizations/beta-build-localization-id'
  end

  describe '#beta_build_localization_build' do
    subject { client.beta_build_localization_build 'beta-build-localization-id', fields: { builds: 'version' } }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/betaBuildLocalizations/beta-build-localization-id/build',
                                      query_params: { fields: { builds: 'version' } }
  end
end
