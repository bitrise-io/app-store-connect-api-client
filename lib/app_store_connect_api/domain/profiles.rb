# frozen_string_literal: true

module AppStoreConnectApi
  module Domain
    module Profiles
      # @see https://developer.apple.com/documentation/appstoreconnectapi/list_and_download_profiles
      def profiles(options = {})
        get '/v1/profiles', options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/read_and_download_profile_information
      def profile(profile_id, options = {})
        get "/v1/profiles/#{profile_id}", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/create_a_profile
      def create_profile(attributes, relationships)
        create '/v1/profiles', data: { attributes: attributes,
                                       relationships: Utils::RelationshipMapper.expand(relationships),
                                       type: 'profiles' }
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/delete_a_profile
      def delete_profile(profile_id)
        delete "/v1/profiles/#{profile_id}"
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/read_the_bundle_id_in_a_profile
      def profile_bundle_id(profile_id, options = {})
        get "/v1/profiles/#{profile_id}/bundleId", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/list_all_certificates_in_a_profile
      def profile_certificates(profile_id, options = {})
        get "/v1/profiles/#{profile_id}/certificates", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/list_all_devices_in_a_profile
      def profile_devices(profile_id, options = {})
        get "/v1/profiles/#{profile_id}/devices", options
      end
    end
  end
end
