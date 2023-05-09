# frozen_string_literal: true

RSpec.describe AppStoreConnectApi::Domain::AppAvailabilities, :api do
  describe '#app_availability' do
    subject { client.app_availability 'app-availability-id', include: 'app' }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/appAvailabilities/app-availability-id',
                                      query_params: { include: 'app' }
  end

  describe '#create_app_availability' do
    subject { client.create_app_availability({ available_in_new_territories: true }, app: 'app-id', available_territories: ['territory-id1']) }

    it_behaves_like 'a POST endpoint', url: 'https://api.appstoreconnect.apple.com/v1/appAvailabilities',
                                       body: {
                                         data: { attributes: { availableInNewTerritories: true },
                                                 relationships: { app: { data: { id: 'app-id', type: 'apps' } },
                                                                  availableTerritories: { data: [{ id: 'territory-id1', type: 'territories' }] } },
                                                 type: 'appAvailabilities' }
                                       }
  end

  describe '#app_availability_available_territories' do
    subject { client.app_availability_available_territories 'app-availability-id', limit: 10 }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/appAvailabilities/app-availability-id/availableTerritories',
                                      query_params: { limit: 10 }
  end
end
