# frozen_string_literal: true

module AppStoreConnectApi
  module Domain
    module UserInvitations
      # @see https://developer.apple.com/documentation/appstoreconnectapi/list_invited_users
      def user_invitations(options = {})
        get '/v1/userInvitations', options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/read_user_invitation_information
      def user_invitation(user_invitation_id, options = {})
        get "/v1/userInvitations/#{user_invitation_id}", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/invite_a_user
      def create_user_invitation(attributes, relationships = {})
        post '/v1/userInvitations', data: { attributes: attributes,
                                            relationships: Utils::RelationshipMapper.expand(relationships, 'visibleApps' => 'apps'),
                                            type: 'user_invitations' }
      end
      alias invite_user create_user_invitation

      # @see https://developer.apple.com/documentation/appstoreconnectapi/cancel_a_user_invitation
      def delete_user_invitation(user_invitation_id)
        delete "/v1/userInvitations/#{user_invitation_id}"
      end
      alias cancel_user_invitation delete_user_invitation

      # @see https://developer.apple.com/documentation/appstoreconnectapi/list_all_apps_visible_to_an_invited_user
      def user_invitation_visible_apps(user_invitation_id, options = {})
        get "/v1/userInvitations/#{user_invitation_id}/visibleApps", options
      end
    end
  end
end
