# frozen_string_literal: true

RSpec.describe AppStoreConnectApi::Domain::AppInfoLocalizations, :api do
  describe '#app_info_localization' do
    subject { client.app_info_localization 'app-info-localization-id', include: 'appInfo' }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/appInfoLocalizations/app-info-localization-id',
                                      query_params: { include: 'appInfo' }
  end

  describe '#create_app_info_localization' do
    subject { client.create_app_info_localization({ locale: 'en-US', name: 'US app info' }, app_info: 'app-info-id') }

    it_behaves_like 'a POST endpoint', url: 'https://api.appstoreconnect.apple.com/v1/appInfoLocalizations',
                                       body: {
                                         data: { attributes: { locale: 'en-US', name: 'US app info' },
                                                 relationships: { appInfo: { data: { id: 'app-info-id', type: 'appInfos' } } },
                                                 type: 'appInfoLocalizations' }
                                       }
  end

  describe '#update_app_info_localization' do
    subject { client.update_app_info_localization 'app-info-localization-id', name: 'New name' }

    it_behaves_like 'a PATCH endpoint', url: 'https://api.appstoreconnect.apple.com/v1/appInfoLocalizations/app-info-localization-id',
                                        body: {
                                          data: { attributes: { name: 'New name' },
                                                  id: 'app-info-localization-id',
                                                  type: 'appInfoLocalizations' }
                                        }
  end

  describe '#delete_app_info_localization' do
    subject { client.delete_app_info_localization 'app-info-localization-id' }

    it_behaves_like 'a DELETE endpoint', url: 'https://api.appstoreconnect.apple.com/v1/appInfoLocalizations/app-info-localization-id'
  end
end
