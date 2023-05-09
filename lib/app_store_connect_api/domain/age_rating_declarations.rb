# frozen_string_literal: true

module AppStoreConnectApi
  module Domain
    module AgeRatingDeclarations
      # @see https://developer.apple.com/documentation/appstoreconnectapi/modify_an_age_rating_declaration
      def update_age_rating_declaration(age_rating_declaration_id, attributes)
        patch "/v1/ageRatingDeclarations/#{age_rating_declaration_id}", data: { attributes: attributes,
                                                                                id: age_rating_declaration_id,
                                                                                type: 'ageRatingDeclarations' }
      end
    end
  end
end
