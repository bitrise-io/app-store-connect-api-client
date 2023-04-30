# frozen_string_literal: true

module AppStoreConnectApi
  module Domain
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

      # @see https://developer.apple.com/documentation/appstoreconnectapi/read_the_app_encryption_declaration_of_a_build
      def build_app_encryption_declaration(build_id, options = {})
        get "/v1/builds/#{build_id}/appEncryptionDeclaration", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/get_the_app_encryption_declaration_id_for_a_build
      def build_app_encryption_declaration_id(build_id)
        get "/v1/builds/#{build_id}/relationships/appEncryptionDeclaration"
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/assign_the_app_encryption_declaration_for_a_build
      def update_build_app_encryption_declaration(build_id, app_encryption_declaration_id)
        patch "/v1/builds/#{build_id}/relationships/appEncryptionDeclaration", data: { id: app_encryption_declaration_id, type: 'appEncryptionDeclarations' }
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/read_the_app_store_version_information_of_a_build
      def build_app_store_version(build_id, options = {})
        get "/v1/builds/#{build_id}/appStoreVersion", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/read_the_beta_app_review_submission_of_a_build
      def build_beta_app_review_submission(build_id, options = {})
        get "/v1/builds/#{build_id}/betaAppReviewSubmission", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/list_all_beta_build_localizations_of_a_build
      def build_beta_build_localizations(build_id, options = {})
        get "/v1/builds/#{build_id}/betaBuildLocalizations", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/read_the_build_beta_details_information_of_a_build
      def build_build_beta_detail(build_id, options = {})
        get "/v1/builds/#{build_id}/buildBetaDetail", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/add_access_for_beta_groups_to_a_build
      def add_build_beta_groups(build_id, beta_group_ids)
        create "/v1/builds/#{build_id}/relationships/betaGroups", data: Utils::RelationshipMapper.resource_keys(beta_group_ids, 'betaGroups')
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/remove_access_for_beta_groups_to_a_build
      def remove_build_beta_groups(build_id, beta_group_ids)
        delete "/v1/builds/#{build_id}/relationships/betaGroups", data: Utils::RelationshipMapper.resource_keys(beta_group_ids, 'betaGroups')
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/list_all_individual_testers_for_a_build
      def build_individual_testers(build_id, options = {})
        get "/v1/builds/#{build_id}/individualTesters", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/get_all_resource_ids_of_individual_testers_for_a_build
      def build_individual_tester_ids(build_id, options = {})
        get "/v1/builds/#{build_id}/relationships/individualTesters", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/assign_individual_testers_to_a_build
      def add_build_individual_testers(build_id, beta_tester_ids)
        create "/v1/builds/#{build_id}/relationships/individualTesters", data: Utils::RelationshipMapper.resource_keys(beta_tester_ids, 'betaTesters')
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/remove_individual_testers_from_a_build
      def remove_build_individual_testers(build_id, beta_tester_ids)
        delete "/v1/builds/#{build_id}/relationships/individualTesters", data: Utils::RelationshipMapper.resource_keys(beta_tester_ids, 'betaTesters')
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/read_the_prerelease_version_of_a_build
      def build_prerelease_version(build_id, options = {})
        get "/v1/builds/#{build_id}/preReleaseVersion", options
      end
    end
  end
end
