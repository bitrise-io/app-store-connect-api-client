# frozen_string_literal: true

RSpec.describe AppStoreConnectApi::Domain::AppCategories, :api do
  describe '#app_categories' do
    subject { client.app_categories limit: 10 }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/appCategories',
                                      query_params: { limit: 10 }
  end

  describe '#app_category' do
    subject { client.app_category 'app-category-id', include: 'parent' }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/appCategories/app-category-id',
                                      query_params: { include: 'parent' }
  end

  describe '#app_category_subcategories' do
    subject { client.app_category_subcategories 'app-category-id', limit: 10 }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/appCategories/app-category-id/subcategories',
                                      query_params: { limit: 10 }
  end

  describe '#app_category_parent' do
    subject { client.app_category_parent 'app-category-id', fields: { app_categories: 'parent' } }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/appCategories/app-category-id/parent',
                                      query_params: { fields: { appCategories: 'parent' } }
  end
end
