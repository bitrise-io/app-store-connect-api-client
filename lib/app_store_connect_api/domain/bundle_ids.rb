# frozen_string_literal: true

module AppStoreConnectApi
  module Domain
    module BundleIds
      # @see https://developer.apple.com/documentation/appstoreconnectapi/list_bundle_ids
      def bundle_ids(options = {})
        get '/v1/bundleIds', options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/read_bundle_id_information
      def bundle_id(bundle_id_id, options = {})
        get "/v1/bundleIds/#{bundle_id_id}", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/register_a_new_bundle_id
      def create_bundle_id(attributes)
        create '/v1/bundleIds', data: { attributes: attributes,
                                        type: 'bundleIds' }
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/modify_a_bundle_id
      def update_bundle_id(bundle_id_id, attributes)
        patch "/v1/bundleIds/#{bundle_id_id}", data: { attributes: attributes,
                                                       id: bundle_id_id,
                                                       type: 'bundleIds' }
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/delete_a_bundle_id
      def delete_bundle_id(bundle_id_id)
        delete "/v1/bundleIds/#{bundle_id_id}"
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/read_the_app_information_of_a_bundle_id
      def bundle_id_app(bundle_id_id, options = {})
        get "/v1/bundleIds/#{bundle_id_id}/app", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/list_all_profiles_for_a_bundle_id
      def bundle_id_profiles(bundle_id_id, options = {})
        get "/v1/bundleIds/#{bundle_id_id}/profiles", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/list_all_capabilities_for_a_bundle_id
      def bundle_id_bundle_id_capabilities(bundle_id_id, options = {})
        get "/v1/bundleIds/#{bundle_id_id}/bundleIdCapabilities", options
      end
    end
  end
end
