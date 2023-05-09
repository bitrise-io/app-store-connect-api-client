# frozen_string_literal: true

RSpec.describe AppStoreConnectApi::Domain::AppPriceSchedules, :api do
  describe '#app_price_schedule' do
    subject { client.app_price_schedule 'app-price-schedule-id', include: 'app' }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/appPriceSchedules/app-price-schedule-id',
                                      query_params: { include: 'app' }
  end

  describe '#create_app_price_schedule' do
    subject do
      client.create_app_price_schedule({ app: 'app-id', base_territory: 'territory-id', manual_prices: ['price-id'] },
                                       ['price-id1', 'price-id2'],
                                       ['territory-id1', 'territory-id2'])
    end

    it_behaves_like 'a POST endpoint', url: 'https://api.appstoreconnect.apple.com/v1/appPriceSchedules',
                                       body: {
                                         data: { relationships: { app: { data: { id: 'app-id', type: 'apps' } },
                                                                  baseTerritory: { data: { id: 'territory-id', type: 'territories' } },
                                                                  manualPrices: { data: [{ id: 'price-id', type: 'appPrices' }] } },
                                                 included: [{ id: 'price-id1', type: 'appPrices' },
                                                            { id: 'price-id2', type: 'appPrices' },
                                                            { id: 'territory-id1', type: 'territories' },
                                                            { id: 'territory-id2', type: 'territories' }],
                                                 type: 'appPriceSchedules' }
                                       }
  end

  describe '#app_price_schedule_automatic_prices' do
    subject { client.app_price_schedule_automatic_prices 'app-price-schedule-id', limit: 10 }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/appPriceSchedules/app-price-schedule-id/automaticPrices',
                                      query_params: { limit: 10 }
  end

  describe '#app_price_schedule_manual_prices' do
    subject { client.app_price_schedule_manual_prices 'app-price-schedule-id', limit: 10 }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/appPriceSchedules/app-price-schedule-id/manualPrices',
                                      query_params: { limit: 10 }
  end

  describe '#app_price_schedule_base_territory' do
    subject { client.app_price_schedule_base_territory 'app-price-schedule-id', fields: { territories: 'currency' } }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/appPriceSchedules/app-price-schedule-id/baseTerritory',
                                      query_params: { fields: { territories: 'currency' } }
  end
end
