# frozen_string_literal: true

RSpec.describe AppStoreConnectApi::Domain::AppInfos, :api do
  describe '#app_info' do
    subject { client.app_info 'app-info-id', include: 'app' }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/appInfos/app-info-id',
                                      query_params: { include: 'app' }
  end

  describe '#update_app_info' do
    subject { client.update_app_info 'app-info-id', primary_category: 'primary-category-id', secondary_category: 'secondary-category-id' }

    it_behaves_like 'a PATCH endpoint', url: 'https://api.appstoreconnect.apple.com/v1/appInfos/app-info-id',
                                        body: {
                                          data: { relationships: { primaryCategory: { data: { id: 'primary-category-id', type: 'appCategories' } },
                                                                   secondaryCategory: { data: { id: 'secondary-category-id', type: 'appCategories' } } },
                                                  id: 'app-info-id',
                                                  type: 'appInfos' }
                                        }
  end

  describe '#app_info_localizations' do
    subject { client.app_info_localizations 'app-info-id', limit: 10 }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/appInfos/app-info-id/appInfoLocalizations',
                                      query_params: { limit: 10 }
  end

  describe '#app_info_age_rating_declaration' do
    subject { client.app_info_age_rating_declaration 'app-info-id', fields: { age_rating_declarations: 'gambling' } }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/appInfos/app-info-id/ageRatingDeclaration',
                                      query_params: { fields: { ageRatingDeclarations: 'gambling' } }
  end

  describe '#app_info_primary_category' do
    subject { client.app_info_primary_category 'app-info-id', include: 'parent' }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/appInfos/app-info-id/primaryCategory',
                                      query_params: { include: 'parent' }
  end

  describe '#app_info_primary_subcategory_one' do
    subject { client.app_info_primary_subcategory_one 'app-info-id', include: 'parent' }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/appInfos/app-info-id/primarySubcategoryOne',
                                      query_params: { include: 'parent' }
  end

  describe '#app_info_primary_subcategory_two' do
    subject { client.app_info_primary_subcategory_two 'app-info-id', include: 'parent' }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/appInfos/app-info-id/primarySubcategoryTwo',
                                      query_params: { include: 'parent' }
  end

  describe '#app_info_secondary_category' do
    subject { client.app_info_secondary_category 'app-info-id', include: 'parent' }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/appInfos/app-info-id/secondaryCategory',
                                      query_params: { include: 'parent' }
  end

  describe '#app_info_secondary_subcategory_one' do
    subject { client.app_info_secondary_subcategory_one 'app-info-id', include: 'parent' }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/appInfos/app-info-id/secondarySubcategoryOne',
                    query_params: { include: 'parent' }
  end

  describe '#app_info_secondary_subcategory_two' do
    subject { client.app_info_secondary_subcategory_two 'app-info-id', include: 'parent' }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/appInfos/app-info-id/secondarySubcategoryTwo',
                    query_params: { include: 'parent' }
  end
end
