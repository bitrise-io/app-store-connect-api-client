# frozen_string_literal: true

module AppStoreConnectApi
  module Domain
    module BuildBetaNotifications
      # @see https://developer.apple.com/documentation/appstoreconnectapi/send_notification_of_an_available_build
      def create_build_beta_notification(relationships)
        post '/v1/buildBetaNotifications', data: { relationships: Utils::RelationshipMapper.expand(relationships),
                                                   type: 'buildBetaNotifications' }
      end
    end
  end
end
