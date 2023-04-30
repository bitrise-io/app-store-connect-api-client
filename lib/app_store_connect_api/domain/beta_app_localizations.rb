# frozen_string_literal: true

module AppStoreConnectApi
  module Domain
    module BetaAppLocalizations
      # @see https://developer.apple.com/documentation/appstoreconnectapi/list_beta_app_localizations
      def beta_app_localizations(options = {})
        get '/v1/betaAppLocalizations', options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/read_beta_app_localization_information
      def beta_app_localization(beta_app_localization_id, options = {})
        get "/v1/betaAppLocalizations/#{beta_app_localization_id}", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/create_a_beta_app_localization
      def create_beta_app_localization(attributes, relationships)
        post '/v1/betaAppLocalizations', data: { attributes: attributes,
                                                 relationships: Utils::RelationshipMapper.expand(relationships),
                                                 type: 'betaAppLocalizations' }
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/modify_a_beta_app_localization
      def update_beta_app_localization(beta_app_localization_id, attributes)
        patch "/v1/betaAppLocalizations/#{beta_app_localization_id}", data: { attributes: attributes,
                                                                              id: beta_app_localization_id,
                                                                              type: 'betaAppLocalizations' }
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/delete_a_beta_app_localization
      def delete_beta_app_localization(beta_app_localization_id)
        delete "/v1/betaAppLocalizations/#{beta_app_localization_id}"
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/read_the_app_information_of_a_beta_app_localization
      def beta_app_localization_app(beta_app_localization_id, options = {})
        get "/v1/betaAppLocalizations/#{beta_app_localization_id}/app", options
      end
    end
  end
end
