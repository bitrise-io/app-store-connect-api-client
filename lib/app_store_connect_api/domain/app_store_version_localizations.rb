# frozen_string_literal: true

module AppStoreConnectApi
  module Domain
    module AppStoreVersionLocalizations
      # @see https://developer.apple.com/documentation/appstoreconnectapi/read_app_store_version_localization_information
      def app_store_version_localization(app_store_version_localization_id, options = {})
        get "/v1/appStoreVersionLocalizations/#{app_store_version_localization_id}", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/create_an_app_store_version_localization
      def create_app_store_version_localization(attributes, relationships)
        create '/v1/appStoreVersionLocalizations', data: { attributes: attributes,
                                                           relationships: Utils::RelationshipMapper.expand(relationships),
                                                           type: 'appStoreVersionLocalizations' }
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/modify_an_app_store_version_localization
      def update_app_store_version_localization(app_store_version_localization_id, attributes)
        patch "/v1/appStoreVersionLocalizations/#{app_store_version_localization_id}", data: { attributes: attributes,
                                                                                               id: app_store_version_localization_id,
                                                                                               type: 'appStoreVersionLocalizations' }
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/delete_an_app_store_version_localization
      def delete_app_store_version_localization(app_store_version_localization_id)
        delete "/v1/appStoreVersionLocalizations/#{app_store_version_localization_id}"
      end
    end
  end
end
