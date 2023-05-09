# frozen_string_literal: true

module AppStoreConnectApi
  module Domain
    module SandboxTesters
      # @see https://developer.apple.com/documentation/appstoreconnectapi/list_sandbox_testers
      def sandbox_testers(options = {})
        get '/v2/sandboxTesters', options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/modify_a_sandbox_tester
      def update_sandbox_tester(sandbox_tester_id, attributes)
        patch "/v2/sandboxTesters/#{sandbox_tester_id}", data: { attributes: attributes,
                                                                 id: sandbox_tester_id,
                                                                 type: 'sandboxTesters' }
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/clear_purchase_history_for_a_sandbox_tester
      def clear_sandbox_tester_purchase_history(sandbox_tester_ids)
        post '/v2/sandboxTestersClearPurchaseHistoryRequest', data: { relationships: Utils::RelationshipMapper.expand(sandbox_testers: sandbox_tester_ids),
                                                                      type: 'sandboxTestersClearPurchaseHistoryRequest' }
      end
    end
  end
end
