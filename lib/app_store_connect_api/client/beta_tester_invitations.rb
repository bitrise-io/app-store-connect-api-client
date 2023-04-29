# frozen_string_literal: true

module AppStoreConnectApi
  class Client
    module BetaTesterInvitations
      # @see https://developer.apple.com/documentation/appstoreconnectapi/send_an_invitation_to_a_beta_tester
      def create_beta_tester_invitation(relationships)
        create '/v1/betaTesterInvitations', data: { relationships: Utils::RelationshipMapper.expand(relationships),
                                                    type: 'betaTesterInvitations' }
      end
    end
  end
end
