# frozen_string_literal: true

RSpec.describe AppStoreConnectApi::Domain::SandboxTesters, :api do
  describe '#sandbox_testers' do
    subject { client.sandbox_testers limit: 10 }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v2/sandboxTesters',
                                      query_params: { limit: 10 }
  end

  describe '#update_sandbox_tester' do
    subject { client.update_sandbox_tester 'sandbox-tester-id', interrupt_purchases: true }

    it_behaves_like 'a PATCH endpoint', url: 'https://api.appstoreconnect.apple.com/v2/sandboxTesters/sandbox-tester-id',
                                        body: {
                                          data: { attributes: { interruptPurchases: true },
                                                  id: 'sandbox-tester-id',
                                                  type: 'sandboxTesters' }
                                        }
  end

  describe '#clear_sandbox_tester_purchase_history' do
    subject { client.clear_sandbox_tester_purchase_history ['tester-id1', 'tester-id2'] }

    it_behaves_like 'a CREATE endpoint', url: 'https://api.appstoreconnect.apple.com/v2/sandboxTestersClearPurchaseHistoryRequest',
                                         body: {
                                           data: { relationships: { sandboxTesters: { data: [{ id: 'tester-id1', type: 'sandboxTesters' },
                                                                                             { id: 'tester-id2', type: 'sandboxTesters' }] } },
                                                   type: 'sandboxTestersClearPurchaseHistoryRequest' }
                                         }
  end
end
