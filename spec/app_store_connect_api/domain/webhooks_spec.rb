# frozen_string_literal: true

RSpec.describe AppStoreConnectApi::Domain::Webhooks, :api do
  describe '#create_webhook' do
    subject do
      client.create_webhook(
        'app-id',
        {
          enabled: true,
          event_types: ['BUILD_UPLOAD_STATE_UPDATED'],
          name: 'My webhook',
          secret: 'secret-string',
          url: 'https://example.com'
        }
      )
    end

    it_behaves_like(
      'a POST endpoint',
      url: 'https://api.appstoreconnect.apple.com/v1/webhooks',
      body: {
        data: {
          attributes: {
            enabled: true,
            eventTypes: ['BUILD_UPLOAD_STATE_UPDATED'],
            name: 'My webhook',
            secret: 'secret-string',
            url: 'https://example.com'
          },
          relationships: {
            app: {
              data: {
                id: 'app-id',
                type: 'apps'
              }
            }
          },
          type: 'webhooks'
        }
      }
    )
  end

  describe '#update_webhook' do
    subject do
      client.update_webhook(
        'webhook-id',
        {
          enabled: false,
          event_types: %w[APP_STORE_VERSION_APP_VERSION_STATE_UPDATED BUILD_UPLOAD_STATE_UPDATED]
        }
      )
    end

    it_behaves_like(
      'a PATCH endpoint',
      url: 'https://api.appstoreconnect.apple.com/v1/webhooks/webhook-id',
      body: {
        data: {
          attributes: {
            enabled: false,
            eventTypes: %w[APP_STORE_VERSION_APP_VERSION_STATE_UPDATED BUILD_UPLOAD_STATE_UPDATED]
          },
          id: 'webhook-id',
          type: 'webhooks'
        }
      }
    )
  end

  describe '#delete_webhook' do
    subject { client.delete_webhook(id: 'webhook-id') }

    it_behaves_like('a DELETE endpoint', url: 'https://api.appstoreconnect.apple.com/v1/webhooks/webhook-id')
  end
end
