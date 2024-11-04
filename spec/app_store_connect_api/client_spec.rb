# frozen_string_literal: true

RSpec.describe AppStoreConnectApi::Client do
  subject(:client) { described_class.new 'issuer-id', 'key-id', 'private-key', 30, is_enterprise_account }

  let(:authorization) { instance_double AppStoreConnectApi::Authorization, token: 'bearer-token' }
  let(:is_enterprise_account) { false }

  before do
    allow(AppStoreConnectApi::Authorization).to receive(:new).with('issuer-id', 'key-id', 'private-key', is_enterprise_account: is_enterprise_account).and_return authorization
  end

  shared_examples 'it raises an error if the request failed' do
    context 'when the request fails without reaching the API' do
      let(:network_error) { Faraday::ConnectionFailed.new 'Network error' }

      before do
        allow_any_instance_of(Faraday::Connection).to receive(:send).and_raise network_error
      end

      it 'raises an error' do
        expect { subject }.to raise_error AppStoreConnectApi::Error do |error|
          expect(error).to have_attributes message: 'Network error',
                                           cause: network_error
        end
      end
    end

    context 'when the request fails and the response has no details' do
      before do
        if is_enterprise_account
          stub_request(:any, /api\.enterprise\.developer\.apple\.com/)
            .to_return(status: 500, body: 'Internal server error')
        else
          stub_request(:any, /api\.appstoreconnect\.apple\.com/)
            .to_return(status: 500, body: 'Internal server error')

        end
      end

      it 'raises an error' do
        expect { subject }.to raise_error AppStoreConnectApi::Error do |error|
          expect(error).to have_attributes message: 'Internal server error'
        end
      end
    end

    context 'when the request fails and the API returns error information' do
      let(:api_response_status) { 401 }
      let(:api_response_body) do
        {
          errors: [
            {
              status: '401',
              code: 'NOT_AUTHORIZED',
              title: 'Authentication credentials are missing or invalid.',
              detail: 'Provide a properly configured and signed bearer token...'
            }
          ]
        }
      end

      it 'raises an error' do
        expect { subject }.to raise_error AppStoreConnectApi::ApiError do |error|
          expect(error).to have_attributes status: 401,
                                           code: 'NOT_AUTHORIZED',
                                           message: 'App Store Connect API request failed',
                                           errors: api_response_body[:errors]
        end
      end
    end

    context 'when the request fails and the API returns multiple errors' do
      let(:api_response_status) { 409 }
      let(:api_response_body) do
        {
          errors: [
            {
              id: 'a5c73a54-ad45-435e-84fb-5a808747b876',
              status: '409',
              code: 'STATE_ERROR 1',
              title: 'The request cannot be fulfilled because of the state of another resource.',
              detail: 'The last version of an app cannot be deleted.'
            },
            {
              id: 'd5bed2ea-28f7-4195-b5b6-e07bb65f551b',
              status: '409',
              code: 'STATE_ERROR 2',
              title: 'The request cannot be fulfilled because of the state of another resource. Almost the same.',
              detail: 'A version cannot be deleted if any build has been uploaded for the platform.'
            }
          ]
        }
      end

      it 'raises an error based on the first error in the response' do
        expect { subject }.to raise_error AppStoreConnectApi::ApiError do |error|
          expect(error).to have_attributes status: 409,
                                           code: 'STATE_ERROR 1',
                                           message: 'App Store Connect API request failed',
                                           errors: api_response_body[:errors]
        end
      end
    end
  end

  describe '#get' do
    subject(:perform_request) { client.get '/test/endpoint' }

    let(:query_params) { {} }
    let(:api_response_status) { 200 }
    let(:api_response_body) { { data: 'response' } }

    before do
      stub_request(:get, 'https://api.appstoreconnect.apple.com/test/endpoint')
        .with(headers: { authorization: 'Bearer bearer-token' },
              query: query_params)
        .to_return(status: api_response_status,
                   body: JSON.dump(api_response_body),
                   headers: { content_type: 'application/json' })
    end

    it 'executes a GET request on the App Store Connect API and returns the response body with symbolized keys' do
      expect(perform_request).to eq 'response'
    end

    context 'when there are query parameters' do
      subject(:perform_request) { client.get '/test/endpoint', review_submission: { data: 'id' } }

      let(:query_params) { { reviewSubmission: { data: 'id' } } }

      it 'passes in the query parameters, transformed into camelCase format' do
        expect(perform_request).to eq 'response'
      end
    end

    context 'when the response contains camelCase fields' do
      let(:api_response_body) { { data: { id: 'some-review-id', attributes: { reviewSubmission: 'valid' } } } }

      it 'transforms camelCase keys into snake_case' do
        expect(perform_request).to eq({ id: 'some-review-id', review_submission: 'valid' })
      end
    end

    include_examples 'it raises an error if the request failed'
  end

  describe '#post' do
    subject(:perform_request) { client.post '/test/endpoint', attributes }

    let(:attributes) { { attribute: 'value' } }
    let(:body) { { attribute: 'value' } }
    let(:api_response_status) { 200 }
    let(:api_response_body) { { data: 'response' } }

    before do
      stub_request(:post, 'https://api.appstoreconnect.apple.com/test/endpoint')
        .with(headers: { authorization: 'Bearer bearer-token',
                         content_type: 'application/json' },
              body: JSON.dump(body))
        .to_return(status: api_response_status,
                   body: JSON.dump(api_response_body),
                   headers: { content_type: 'application/json' })
    end

    it 'executes a CREATE request on the App Store Connect API and returns the response body with symbolized keys' do
      expect(perform_request).to eq 'response'
    end

    context 'when the body contains snake case attributes' do
      let(:attributes) { { whats_new: 'value' } }
      let(:body) { { whatsNew: 'value' } }

      it 'transforms the attributes into camelCase format' do
        expect(perform_request).to eq 'response'
      end
    end

    context 'when the response contains camelCase fields' do
      let(:api_response_body) { { data: { id: 'some-review-id', attributes: { reviewSubmission: 'valid' } } } }

      it 'transforms camelCase keys into snake_case' do
        expect(perform_request).to eq({ id: 'some-review-id', review_submission: 'valid' })
      end
    end

    include_examples 'it raises an error if the request failed'
  end

  describe '#patch' do
    subject(:perform_request) { client.patch '/test/endpoint', attributes }

    let(:attributes) { { attribute: 'value' } }
    let(:body) { { attribute: 'value' } }
    let(:api_response_status) { 200 }
    let(:api_response_body) { { data: 'response' } }

    before do
      stub_request(:patch, 'https://api.appstoreconnect.apple.com/test/endpoint')
        .with(headers: { authorization: 'Bearer bearer-token',
                         content_type: 'application/json' },
              body: JSON.dump(body))
        .to_return(status: api_response_status,
                   body: JSON.dump(api_response_body),
                   headers: { content_type: 'application/json' })
    end

    it 'executes a PATCH request on the App Store Connect API and returns the response body with symbolized keys' do
      expect(perform_request).to eq 'response'
    end

    context 'when the body contains snake case attributes' do
      let(:attributes) { { whats_new: 'value' } }
      let(:body) { { whatsNew: 'value' } }

      it 'transforms the attributes into camelCase format' do
        expect(perform_request).to eq 'response'
      end
    end

    context 'when the response contains camelCase fields' do
      let(:api_response_body) { { data: { id: 'some-review-id', attributes: { reviewSubmission: 'valid' } } } }

      it 'transforms camelCase keys into snake_case' do
        expect(perform_request).to eq({ id: 'some-review-id', review_submission: 'valid' })
      end
    end

    include_examples 'it raises an error if the request failed'
  end

  describe '#delete' do
    subject(:perform_request) { client.delete '/test/endpoint' }

    let(:api_response_status) { 200 }
    let(:api_response_body) { { data: 'response' } }

    before do
      stub_request(:delete, 'https://api.appstoreconnect.apple.com/test/endpoint')
        .with(headers: { authorization: 'Bearer bearer-token' })
        .to_return(status: api_response_status,
                   body: JSON.dump(api_response_body),
                   headers: { content_type: 'application/json' })
    end

    it 'executes a DELETE request on the App Store Connect API and returns the response body with symbolized keys' do
      expect(perform_request).to eq 'response'
    end

    context 'when the response contains camelCase fields' do
      let(:api_response_body) { { data: { id: 'some-review-id', attributes: { reviewSubmission: 'valid' } } } }

      it 'transforms camelCase keys into snake_case' do
        expect(client.delete('/test/endpoint')).to eq({ id: 'some-review-id', review_submission: 'valid' })
      end
    end

    context 'when the request has a body' do
      let(:perform_request) { client.delete '/test/endpoint', attributes }

      let(:attributes) { { app_store_version: 'app-store-version-id' } }
      let(:body) { { appStoreVersin: 'app-store-version-id' } }

      before do
        stub_request(:patch, 'https://api.appstoreconnect.apple.com/test/endpoint')
          .with(headers: { authorization: 'Bearer bearer-token',
                           content_type: 'application/json' },
                body: JSON.dump(body))
          .to_return(status: api_response_status,
                     body: JSON.dump(api_response_body),
                     headers: { content_type: 'application/json' })
      end

      it 'executes the DELETE request including the body' do
        expect(perform_request).to eq 'response'
      end
    end

    include_examples 'it raises an error if the request failed'
  end

  describe '#more?' do
    subject { client.more? resource }

    let(:resource) { { links: { next: 'https://api.appstoreconnect.apple.com/link-to-next-page' } } }

    it { is_expected.to be true }

    context 'when there is no "next" link in the resource' do
      let(:resource) { { links: {} } }

      it { is_expected.to be false }
    end
  end

  describe '#next' do
    subject(:next_page) { client.next resource }

    let(:resource) { { links: { next: 'https://api.appstoreconnect.apple.com/link-to-next-page?page=2' } } }
    let(:api_response_status) { 200 }
    let(:api_response_body) { { data: 'response' } }

    before do
      stub_request(:get, 'https://api.appstoreconnect.apple.com/link-to-next-page?page=2')
        .with(headers: { authorization: 'Bearer bearer-token' })
        .to_return(status: api_response_status,
                   body: JSON.dump(api_response_body),
                   headers: { content_type: 'application/json' })
    end

    it 'fetches the next page of results based on the "next" link in the resource' do
      expect(next_page).to eq 'response'
    end

    include_examples 'it raises an error if the request failed'
  end

  describe 'using Enterprise API' do
    let(:is_enterprise_account) { true }

    describe '#get' do
      subject(:perform_request) { client.get '/test/endpoint' }

      let(:query_params) { {} }
      let(:api_response_status) { 200 }
      let(:api_response_body) { { data: 'response' } }

      before do
        stub_request(:get, 'https://api.enterprise.developer.apple.com/test/endpoint')
          .with(headers: { authorization: 'Bearer bearer-token' },
                query: query_params)
          .to_return(status: api_response_status,
                     body: JSON.dump(api_response_body),
                     headers: { content_type: 'application/json' })
      end

      it 'executes a GET request on the App Store Connect API and returns the response body with symbolized keys' do
        expect(perform_request).to eq 'response'
      end

      context 'when there are query parameters' do
        subject(:perform_request) { client.get '/test/endpoint', review_submission: { data: 'id' } }

        let(:query_params) { { reviewSubmission: { data: 'id' } } }

        it 'passes in the query parameters, transformed into camelCase format' do
          expect(perform_request).to eq 'response'
        end
      end

      context 'when the response contains camelCase fields' do
        let(:api_response_body) { { data: { id: 'some-review-id', attributes: { reviewSubmission: 'valid' } } } }

        it 'transforms camelCase keys into snake_case' do
          expect(perform_request).to eq({ id: 'some-review-id', review_submission: 'valid' })
        end
      end

      include_examples 'it raises an error if the request failed'
    end

    describe '#post' do
      subject(:perform_request) { client.post '/test/endpoint', attributes }

      let(:attributes) { { attribute: 'value' } }
      let(:body) { { attribute: 'value' } }
      let(:api_response_status) { 200 }
      let(:api_response_body) { { data: 'response' } }

      before do
        stub_request(:post, 'https://api.enterprise.developer.apple.com/test/endpoint')
          .with(headers: { authorization: 'Bearer bearer-token',
                           content_type: 'application/json' },
                body: JSON.dump(body))
          .to_return(status: api_response_status,
                     body: JSON.dump(api_response_body),
                     headers: { content_type: 'application/json' })
      end

      it 'executes a CREATE request on the App Store Connect API and returns the response body with symbolized keys' do
        expect(perform_request).to eq 'response'
      end

      context 'when the body contains snake case attributes' do
        let(:attributes) { { whats_new: 'value' } }
        let(:body) { { whatsNew: 'value' } }

        it 'transforms the attributes into camelCase format' do
          expect(perform_request).to eq 'response'
        end
      end

      context 'when the response contains camelCase fields' do
        let(:api_response_body) { { data: { id: 'some-review-id', attributes: { reviewSubmission: 'valid' } } } }

        it 'transforms camelCase keys into snake_case' do
          expect(perform_request).to eq({ id: 'some-review-id', review_submission: 'valid' })
        end
      end

      include_examples 'it raises an error if the request failed'
    end

    describe '#patch' do
      subject(:perform_request) { client.patch '/test/endpoint', attributes }

      let(:attributes) { { attribute: 'value' } }
      let(:body) { { attribute: 'value' } }
      let(:api_response_status) { 200 }
      let(:api_response_body) { { data: 'response' } }

      before do
        stub_request(:patch, 'https://api.enterprise.developer.apple.com/test/endpoint')
          .with(headers: { authorization: 'Bearer bearer-token',
                           content_type: 'application/json' },
                body: JSON.dump(body))
          .to_return(status: api_response_status,
                     body: JSON.dump(api_response_body),
                     headers: { content_type: 'application/json' })
      end

      it 'executes a PATCH request on the App Store Connect API and returns the response body with symbolized keys' do
        expect(perform_request).to eq 'response'
      end

      context 'when the body contains snake case attributes' do
        let(:attributes) { { whats_new: 'value' } }
        let(:body) { { whatsNew: 'value' } }

        it 'transforms the attributes into camelCase format' do
          expect(perform_request).to eq 'response'
        end
      end

      context 'when the response contains camelCase fields' do
        let(:api_response_body) { { data: { id: 'some-review-id', attributes: { reviewSubmission: 'valid' } } } }

        it 'transforms camelCase keys into snake_case' do
          expect(perform_request).to eq({ id: 'some-review-id', review_submission: 'valid' })
        end
      end

      include_examples 'it raises an error if the request failed'
    end

    describe '#delete' do
      subject(:perform_request) { client.delete '/test/endpoint' }

      let(:api_response_status) { 200 }
      let(:api_response_body) { { data: 'response' } }

      before do
        stub_request(:delete, 'https://api.enterprise.developer.apple.com/test/endpoint')
          .with(headers: { authorization: 'Bearer bearer-token' })
          .to_return(status: api_response_status,
                     body: JSON.dump(api_response_body),
                     headers: { content_type: 'application/json' })
      end

      it 'executes a DELETE request on the App Store Connect API and returns the response body with symbolized keys' do
        expect(perform_request).to eq 'response'
      end

      context 'when the response contains camelCase fields' do
        let(:api_response_body) { { data: { id: 'some-review-id', attributes: { reviewSubmission: 'valid' } } } }

        it 'transforms camelCase keys into snake_case' do
          expect(client.delete('/test/endpoint')).to eq({ id: 'some-review-id', review_submission: 'valid' })
        end
      end

      context 'when the request has a body' do
        let(:perform_request) { client.delete '/test/endpoint', attributes }

        let(:attributes) { { app_store_version: 'app-store-version-id' } }
        let(:body) { { appStoreVersin: 'app-store-version-id' } }

        before do
          stub_request(:patch, 'https://api.enterprise.developer.apple.com/test/endpoint')
            .with(headers: { authorization: 'Bearer bearer-token',
                             content_type: 'application/json' },
                  body: JSON.dump(body))
            .to_return(status: api_response_status,
                       body: JSON.dump(api_response_body),
                       headers: { content_type: 'application/json' })
        end

        it 'executes the DELETE request including the body' do
          expect(perform_request).to eq 'response'
        end
      end

      include_examples 'it raises an error if the request failed'
    end

    describe '#more?' do
      subject { client.more? resource }

      let(:resource) { { links: { next: 'https://api.enterprise.developer.apple.com/link-to-next-page' } } }

      it { is_expected.to be true }

      context 'when there is no "next" link in the resource' do
        let(:resource) { { links: {} } }

        it { is_expected.to be false }
      end
    end

    describe '#next' do
      subject(:next_page) { client.next resource }

      let(:resource) { { links: { next: 'https://api.enterprise.developer.apple.com/link-to-next-page?page=2' } } }
      let(:api_response_status) { 200 }
      let(:api_response_body) { { data: 'response' } }

      before do
        stub_request(:get, 'https://api.enterprise.developer.apple.com/link-to-next-page?page=2')
          .with(headers: { authorization: 'Bearer bearer-token' })
          .to_return(status: api_response_status,
                     body: JSON.dump(api_response_body),
                     headers: { content_type: 'application/json' })
      end

      it 'fetches the next page of results based on the "next" link in the resource' do
        expect(next_page).to eq 'response'
      end

      include_examples 'it raises an error if the request failed'
    end
  end
end
