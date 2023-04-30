# frozen_string_literal: true

module AppStoreConnectApi
  module Domain
    module AppStoreVersionReleaseRequests
      # @see https://developer.apple.com/documentation/appstoreconnectapi/manually_release_an_app_store_approved_version_of_your_app
      def create_app_store_version_release_request(relationships)
        post '/v1/appStoreVersionReleaseRequests', data: { relationships: Utils::RelationshipMapper.expand(relationships),
                                                           type: 'appStoreVersionReleaseRequests' }
      end
    end
  end
end
