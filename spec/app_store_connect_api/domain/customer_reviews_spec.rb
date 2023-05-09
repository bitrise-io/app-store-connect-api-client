# frozen_string_literal: true

RSpec.describe AppStoreConnectApi::Domain::CustomerReviews, :api do
  describe '#customer_review' do
    subject { client.customer_review 'customer-review-id', include: 'app' }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/customerReviews/customer-review-id',
                                      query_params: { include: 'app' }
  end
end
