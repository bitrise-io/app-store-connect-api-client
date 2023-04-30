# frozen_string_literal: true

module AppStoreConnectApi
  module Domain
    module BundleIdCapabilities
      # @see https://developer.apple.com/documentation/appstoreconnectapi/enable_a_capability
      def create_bundle_id_capability(attributes, relationships)
        post '/v1/bundleIdCapabilities', data: { attributes: attributes,
                                                 relationships: Utils::RelationshipMapper.expand(relationships),
                                                 type: 'bundleIdCapabilities' }
      end
      alias :enable_bundle_id_capability :create_bundle_id_capability

      # @see https://developer.apple.com/documentation/appstoreconnectapi/modify_a_capability_configuration
      def update_bundle_id_capability(bundle_id_capability_id, attributes)
        patch "/v1/bundleIdCapabilities/#{bundle_id_capability_id}", data: { attributes: attributes,
                                                                             id: bundle_id_capability_id,
                                                                             type: 'bundleIdCapabilities' }
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/disable_a_capability
      def delete_bundle_id_capability(bundle_id_capability_id)
        delete "/v1/bundleIdCapabilities/#{bundle_id_capability_id}"
      end
      alias :disable_bundle_id_capability :delete_bundle_id_capability
    end
  end
end
