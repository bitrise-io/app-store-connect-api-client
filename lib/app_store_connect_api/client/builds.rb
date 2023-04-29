# frozen_string_literal: true

module AppStoreConnectApi
  class Client
    module Builds
      # @see https://developer.apple.com/documentation/appstoreconnectapi/list_builds
      def builds(options = {})
        get '/v1/builds', options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/read_build_information
      def build(build_id, options = {})
        get "/v1/builds/#{build_id}", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/modify_a_build
      def update_build(build_id, attributes = {}, relationships = {})
        patch "/v1/builds/#{build_id}", data: { attributes: attributes,
                                                relationships: Utils::RelationshipMapper.expand(relationships),
                                                id: build_id,
                                                type: 'builds' }
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/read_the_app_information_of_a_build
      def build_app(build_id, options = {})
        get "/v1/builds/#{build_id}/app", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/read_the_app_store_version_information_of_a_build
      def build_app_store_version(build_id, options = {})
        get "/v1/builds/#{build_id}/appStoreVersion", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/add_access_for_beta_groups_to_a_build
      def add_build_beta_groups(build_id, beta_groups)
        create "/v1/builds/#{build_id}/relationships/betaGroups", data: Utils::RelationshipMapper.resource_keys(beta_groups, 'betaGroups')
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/remove_access_for_beta_groups_to_a_build
      def remove_build_beta_groups(build_id, beta_groups)
        delete "/v1/builds/#{build_id}/relationships/betaGroups", data: Utils::RelationshipMapper.resource_keys(beta_groups, 'betaGroups')
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/assign_individual_testers_to_a_build
      def add_build_beta_testers(build_id, beta_testers)
        create "/v1/builds/#{build_id}/relationships/individualTesters", data: Utils::RelationshipMapper.resource_keys(beta_testers, 'betaTesters')
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/remove_individual_testers_from_a_build
      def remove_build_beta_testers(build_id, beta_testers)
        delete "/v1/builds/#{build_id}/relationships/individualTesters", data: Utils::RelationshipMapper.resource_keys(beta_testers, 'betaTesters')
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/read_the_prerelease_version_of_a_build
      def build_prerelease_version(build_id, options = {})
        get "/v1/builds/#{build_id}/preReleaseVersion", options
      end
    end
  end
end
