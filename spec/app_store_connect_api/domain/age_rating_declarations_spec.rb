# frozen_string_literal: true

RSpec.describe AppStoreConnectApi::Domain::AgeRatingDeclarations, :api do
  describe '#update_age_rating_declaration' do
    subject { client.update_age_rating_declaration 'age-rating-declaration-id', gambling: false }

    it_behaves_like 'a PATCH endpoint', url: 'https://api.appstoreconnect.apple.com/v1/ageRatingDeclarations/age-rating-declaration-id',
                                        body: {
                                          data: { attributes: { gambling: false },
                                                  id: 'age-rating-declaration-id',
                                                  type: 'ageRatingDeclarations' }
                                        }
  end
end
