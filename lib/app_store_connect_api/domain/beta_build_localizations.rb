# frozen_string_literal: true

module AppStoreConnectApi
  module Domain
    module BetaBuildLocalizations
      # @see https://developer.apple.com/documentation/appstoreconnectapi/list_beta_build_localizations
      def beta_build_localizations(options = {})
        get '/v1/betaBuildLocalizations', options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/read_beta_build_localization_information
      def beta_build_localization(beta_build_localization_id, options = {})
        get "/v1/betaBuildLocalizations/#{beta_build_localization_id}", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/create_a_beta_build_localization
      def create_beta_build_localization(attributes, relationships)
        post '/v1/betaBuildLocalizations', data: { attributes: attributes,
                                                   relationships: Utils::RelationshipMapper.expand(relationships),
                                                   type: 'betaBuildLocalizations' }
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/modify_a_beta_build_localization
      def update_beta_build_localization(beta_build_localization_id, attributes)
        patch "/v1/betaBuildLocalizations/#{beta_build_localization_id}", data: { attributes: attributes,
                                                                                  id: beta_build_localization_id,
                                                                                  type: 'betaBuildLocalizations' }
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/delete_a_beta_build_localization
      def delete_beta_build_localization(beta_build_localization_id)
        delete "/v1/betaBuildLocalizations/#{beta_build_localization_id}"
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/read_the_build_information_of_a_beta_build_localization
      def beta_build_localization_build(beta_build_localization_id, options = {})
        get "/v1/betaBuildLocalizations/#{beta_build_localization_id}/build", options
      end
    end
  end
end
