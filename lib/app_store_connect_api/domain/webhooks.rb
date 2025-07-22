# frozen_string_literal: true

module AppStoreConnectApi
  module Domain
    module Webhooks
      # @see https://developer.apple.com/documentation/appstoreconnectapi/post-v1-webhooks
      def create_webhook(app_id, attributes)
        post(
          '/v1/webhooks',
          data: {
            attributes: attributes,
            relationships: {
              app: {
                data: {
                  id: app_id,
                  type: 'apps'
                }
              },
            },
            type: 'webhooks'
          }
        )
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/delete-v1-webhooks-_id_
      def delete_webhook(id:)
        delete("/v1/webhooks/#{id}")
      end
    end
  end
end
