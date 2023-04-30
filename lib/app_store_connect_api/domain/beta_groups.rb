# frozen_string_literal: true

module AppStoreConnectApi
  module Domain
    module BetaGroups
      # @see https://developer.apple.com/documentation/appstoreconnectapi/list_beta_groups
      def beta_groups(options = {})
        get '/v1/betaGroups', options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/read_beta_group_information
      def beta_group(beta_group_id, options = {})
        get "/v1/betaGroups/#{beta_group_id}", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/create_a_beta_group
      def create_beta_group(attributes, relationships)
        create '/v1/betaGroups', data: { attributes: attributes,
                                         relationships: Utils::RelationshipMapper.expand(relationships),
                                         type: 'betaGroups' }
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/modify_a_beta_group
      def update_beta_group(beta_group_id, attributes)
        patch "/v1/betaGroups/#{beta_group_id}", data: { attributes: attributes,
                                                         id: beta_group_id,
                                                         type: 'betaGroups' }
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/delete_a_beta_group
      def delete_beta_group(beta_group_id)
        delete "/v1/betaGroups/#{beta_group_id}"
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/read_the_app_information_of_a_beta_group
      def beta_group_app(beta_group_id, options = {})
        get "/v1/betaGroups/#{beta_group_id}/app", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/list_all_beta_testers_in_a_beta_group
      def beta_group_beta_testers(beta_group_id, options = {})
        get "/v1/betaGroups/#{beta_group_id}/betaTesters", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/get_all_beta_tester_ids_in_a_beta_group
      def beta_group_beta_tester_ids(beta_group_id, options = {})
        get "/v1/betaGroups/#{beta_group_id}/relationships/betaTesters", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/add_beta_testers_to_a_beta_group
      def add_beta_group_beta_testers(beta_group_id, beta_testers)
        create "/v1/betaGroups/#{beta_group_id}/relationships/betaTesters", data: Utils::RelationshipMapper.resource_keys(beta_testers, 'betaTesters')
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/remove_beta_testers_from_a_beta_group
      def remove_beta_group_beta_testers(beta_group_id, beta_testers)
        delete "/v1/betaGroups/#{beta_group_id}/relationships/betaTesters", data: Utils::RelationshipMapper.resource_keys(beta_testers, 'betaTesters')
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/list_all_builds_for_a_beta_group
      def beta_group_builds(beta_group_id, options = {})
        get "/v1/betaGroups/#{beta_group_id}/builds", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/get_all_build_ids_in_a_beta_group
      def beta_group_build_ids(beta_group_id, options = {})
        get "/v1/betaGroups/#{beta_group_id}/relationships/builds", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/add_builds_to_a_beta_group
      def add_beta_group_builds(beta_group_id, builds)
        create "/v1/betaGroups/#{beta_group_id}/relationships/builds", data: Utils::RelationshipMapper.resource_keys(builds, 'builds')
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/remove_builds_from_a_beta_group
      def remove_beta_group_builds(beta_group_id, builds)
        delete "/v1/betaGroups/#{beta_group_id}/relationships/builds", data: Utils::RelationshipMapper.resource_keys(builds, 'builds')
      end
    end
  end
end
