# frozen_string_literal: true

module AppStoreConnectApi
  class Client
    module Apps
      # @see https://developer.apple.com/documentation/appstoreconnectapi/list_apps
      def apps(options = {})
        get '/v1/apps', options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/read_app_information
      def app(app_id, options = {})
        get "/v1/apps/#{app_id}", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/modify_an_app
      def update_app(app_id, attributes = {}, app_prices = [])
        patch "/v1/apps/#{app_id}", data: { attributes: attributes,
                                            id: app_id,
                                            type: 'apps' },
                                    included: Utils::RelationshipMapper.to_resource_keys(app_prices, 'appPrices')
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/list_all_app_store_versions_for_an_app
      def app_app_store_versions(app_id, options = {})
        get "/v1/apps/#{app_id}/appStoreVersions", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/list_all_beta_groups_for_an_app
      def app_beta_groups(app_id, options = {})
        get "/v1/apps/#{app_id}/betaGroups", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/list_all_builds_of_an_app
      def app_builds(app_id, options = {})
        get "/v1/apps/#{app_id}/builds", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/list_all_prerelease_versions_for_an_app
      def app_prerelease_versions(app_id, options = {})
        get "/v1/apps/#{app_id}/preReleaseVersions", options
      end
    end
  end
end
