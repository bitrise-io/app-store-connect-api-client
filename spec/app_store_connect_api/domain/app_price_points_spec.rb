# frozen_string_literal: true

RSpec.describe AppStoreConnectApi::Domain::AppPricePoints, :api do
  describe '#app_price_point' do
    subject { client.app_price_point 'app-price-point-id', include: 'app' }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v3/appPricePoints/app-price-point-id',
                                      query_params: { include: 'app' }
  end

  describe '#app_price_point_equalizations' do
    subject { client.app_price_point_equalizations 'app-price-point-id', limit: 10 }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v3/appPricePoints/app-price-point-id/equalizations',
                                      query_params: { limit: 10 }
  end
end
