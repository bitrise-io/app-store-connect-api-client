# frozen_string_literal: true

module AppStoreConnectApi
  module Domain
    module AppStoreVersionPhasedReleases
      # @see https://developer.apple.com/documentation/appstoreconnectapi/create_an_app_store_version_phased_release
      def create_app_store_version_phased_release(attributes, relationships)
        post '/v1/appStoreVersionPhasedReleases', data: { attributes: attributes,
                                                          relationships: Utils::RelationshipMapper.expand(relationships),
                                                          type: 'appStoreVersionPhasedReleases' }
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/modify_an_app_store_version_phased_release
      def update_app_store_version_phased_release(app_store_version_phased_release_id, attributes)
        patch "/v1/appStoreVersionPhasedReleases/#{app_store_version_phased_release_id}", data: { attributes: attributes,
                                                                                                  id: app_store_version_phased_release_id,
                                                                                                  type: 'appStoreVersionPhasedReleases' }
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/delete_an_app_store_version_phased_release
      def delete_app_store_version_phased_release(app_store_version_phased_release_id)
        delete "/v1/appStoreVersionPhasedReleases/#{app_store_version_phased_release_id}"
      end
    end
  end
end
