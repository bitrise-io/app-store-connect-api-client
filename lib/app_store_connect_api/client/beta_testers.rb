# frozen_string_literal: true

module AppStoreConnectApi
  class Client
    module BetaTesters
      # @see https://developer.apple.com/documentation/appstoreconnectapi/list_beta_testers
      def beta_testers(options = {})
        get '/v1/betaTesters', options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/read_beta_tester_information
      def beta_tester(beta_tester_id, options = {})
        get "/v1/betaTesters/#{beta_tester_id}", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/create_a_beta_tester
      def create_beta_tester(attributes, relationships)
        create '/v1/betaTesters', data: { attributes: attributes,
                                          relationships: Utils::RelationshipMapper.expand(relationships),
                                          type: 'betaTesters' }
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/delete_a_beta_tester
      def delete_beta_tester(beta_tester_id)
        delete "/v1/betaTesters/#{beta_tester_id}"
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/list_all_apps_for_a_beta_tester
      def beta_tester_apps(beta_tester_id, options = {})
        get "/v1/betaTesters/#{beta_tester_id}/apps", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/get_all_app_resource_ids_for_a_beta_tester
      def beta_tester_app_ids(beta_tester_id, options = {})
        get "/v1/betaTesters/#{beta_tester_id}/relationships/apps", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/remove_a_beta_tester_s_access_to_apps
      def remove_beta_tester_apps(beta_tester_id, apps)
        delete "/v1/betaTesters/#{beta_tester_id}/relationships/apps", data: Utils::RelationshipMapper.resource_keys(apps, 'apps')
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/list_all_beta_groups_to_which_a_beta_tester_belongs
      def beta_tester_beta_groups(beta_tester_id, options = {})
        get "/v1/betaTesters/#{beta_tester_id}/betaGroups", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/get_all_beta_group_ids_of_a_beta_tester_s_groups
      def beta_tester_beta_group_ids(beta_tester_id, options = {})
        get "/v1/betaTesters/#{beta_tester_id}/relationships/betaGroups", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/add_a_beta_tester_to_beta_groups
      def add_beta_tester_beta_groups(beta_tester_id, beta_groups)
        create "/v1/betaTesters/#{beta_tester_id}/relationships/betaGroups", data: Utils::RelationshipMapper.resource_keys(beta_groups, 'betaGroups')
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/remove_a_beta_tester_from_beta_groups
      def remove_beta_tester_beta_groups(beta_tester_id, beta_groups)
        delete "/v1/betaTesters/#{beta_tester_id}/relationships/betaGroups", data: Utils::RelationshipMapper.resource_keys(beta_groups, 'betaGroups')
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/list_all_builds_individually_assigned_to_a_beta_tester
      def beta_tester_builds(beta_tester_id, options = {})
        get "/v1/betaTesters/#{beta_tester_id}/builds", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/get_all_ids_of_builds_individually_assigned_to_a_beta_tester
      def beta_tester_build_ids(beta_tester_id, options = {})
        get "/v1/betaTesters/#{beta_tester_id}/relationships/builds", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/individually_assign_a_beta_tester_to_builds
      def add_beta_tester_builds(beta_tester_id, builds)
        create "/v1/betaTesters/#{beta_tester_id}/relationships/builds", data: Utils::RelationshipMapper.resource_keys(builds, 'builds')
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/individually_unassign_a_beta_tester_from_builds
      def remove_beta_tester_builds(beta_tester_id, builds)
        delete "/v1/betaTesters/#{beta_tester_id}/relationships/builds", data: Utils::RelationshipMapper.resource_keys(builds, 'builds')
      end
    end
  end
end
