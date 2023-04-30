# frozen_string_literal: true

module AppStoreConnectApi
  module Domain
    module Users
      # @see https://developer.apple.com/documentation/appstoreconnectapi/list_users
      def users(options = {})
        get '/v1/users', options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/read_user_information
      def user(user_id, options = {})
        get "/v1/users/#{user_id}", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/modify_a_user_account
      def update_user(user_id, attributes = {}, relationships = {})
        patch "/v1/users/#{user_id}", data: { attributes: attributes,
                                              relationships: Utils::RelationshipMapper.expand(relationships, 'visibleApps' => 'apps'),
                                              id: user_id,
                                              type: 'users' }
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/remove_a_user_account
      def delete_user(user_id)
        delete "/v1/users/#{user_id}"
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/list_all_apps_visible_to_a_user
      def user_visible_apps(user_id, options = {})
        get "/v1/users/#{user_id}/visibleApps", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/get_all_visible_app_resource_ids_for_a_user
      def user_visible_app_ids(user_id, options = {})
        get "/v1/users/#{user_id}/relationships/visibleApps", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/add_visible_apps_to_a_user
      def add_user_visible_apps(user_id, visible_app_ids)
        create "/v1/users/#{user_id}/relationships/visibleApps", data: Utils::RelationshipMapper.resource_keys(visible_app_ids, 'apps')
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/replace_the_list_of_visible_apps_for_a_user
      def replace_user_visible_apps(user_id, visible_app_ids)
        patch "/v1/users/#{user_id}/relationships/visibleApps", data: Utils::RelationshipMapper.resource_keys(visible_app_ids, 'apps')
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/remove_visible_apps_from_a_user
      def remove_user_visible_apps(user_id, visible_app_ids)
        delete "/v1/users/#{user_id}/relationships/visibleApps", data: Utils::RelationshipMapper.resource_keys(visible_app_ids, 'apps')
      end
    end
  end
end
