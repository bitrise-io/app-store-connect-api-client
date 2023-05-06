# frozen_string_literal: true

module AppStoreConnectApi
  module Domain
    module AppInfoLocalizations
      # @see https://developer.apple.com/documentation/appstoreconnectapi/read_app_info_localization_information
      def app_info_localization(app_info_localization_id, options = {})
        get "/v1/appInfoLocalizations/#{app_info_localization_id}", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/create_an_app_info_localization
      def create_app_info_localization(attributes, relationships)
        post '/v1/appInfoLocalizations', data: { attributes: attributes,
                                                 relationships: Utils::RelationshipMapper.expand(relationships),
                                                 type: 'appInfoLocalizations' }
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/modify_an_app_info_localization
      def update_app_info_localization(app_info_localization_id, attributes)
        patch "/v1/appInfoLocalizations/#{app_info_localization_id}", data: { attributes: attributes,
                                                                              id: app_info_localization_id,
                                                                              type: 'appInfoLocalizations' }
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/delete_an_app_info_localization
      def delete_app_info_localization(app_info_localization_id)
        delete "/v1/appInfoLocalizations/#{app_info_localization_id}"
      end
    end
  end
end
