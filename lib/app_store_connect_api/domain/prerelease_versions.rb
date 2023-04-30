# frozen_string_literal: true

module AppStoreConnectApi
  module Domain
    module PrereleaseVersions
      # @see https://developer.apple.com/documentation/appstoreconnectapi/list_prerelease_versions
      def prerelease_versions(options = {})
        get '/v1/preReleaseVersions', options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/read_prerelease_version_information
      def prerelease_version(prerelease_version_id, options = {})
        get "/v1/preReleaseVersions/#{prerelease_version_id}", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/read_the_app_information_of_a_prerelease_version
      def prerelease_version_app(prerelease_version_id, options = {})
        get "/v1/preReleaseVersions/#{prerelease_version_id}/app", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/list_all_builds_of_a_prerelease_version
      def prerelease_version_builds(prerelease_version_id, options = {})
        get "/v1/preReleaseVersions/#{prerelease_version_id}/builds", options
      end
    end
  end
end
