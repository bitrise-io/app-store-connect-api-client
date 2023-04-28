# frozen_string_literal: true

RSpec.describe AppStoreConnectApi::Client do
  subject(:client) { described_class.new 'issuer-id', 'key-id', 'private-key' }

  let(:authorization) { instance_double AppStoreConnectApi::Authorization, token: 'bearer-token' }

  before do
    allow(AppStoreConnectApi::Authorization).to receive(:new).with('issuer-id', 'key-id', 'private-key').and_return authorization
  end

  describe '#get' do
    let(:query_params) { {} }
    let(:api_response) { { data: 'response' } }

    before do
      stub_request(:get, 'https://api.appstoreconnect.apple.com/test/endpoint')
        .with(headers: { authorization: 'Bearer bearer-token' },
              query: query_params)
        .to_return(status: 200,
                   body: JSON.dump(api_response),
                   headers: { content_type: 'application/json' })
    end

    it 'executes a GET request on the App Store Connect API and returns the response body with symbolized keys' do
      response = client.get '/test/endpoint'
      expect(response).to eq data: 'response'
    end

    context 'when there are query parameters' do
      let(:query_params) { { reviewSubmission: { data: 'id' } } }

      it 'passes in the query parameters, transformed into camelCase format' do
        response = client.get '/test/endpoint', review_submission: { data: 'id' }
        expect(response).to eq data: 'response'
      end
    end

    context 'when the response contains camelCase fields' do
      let(:api_response) { { reviewSubmission: { data: { id: 'some-id' } } } }

      it 'transforms camelCase keys into snake_case' do
        response = client.get '/test/endpoint'
        expect(response).to eq review_submission: { data: { id: 'some-id' } }
      end
    end
  end

  describe '#create' do
    let(:body) { { attribute: 'value' } }
    let(:api_response) { { data: 'response' } }

    before do
      stub_request(:post, 'https://api.appstoreconnect.apple.com/test/endpoint')
        .with(headers: { authorization: 'Bearer bearer-token',
                         content_type: 'application/json' },
              body: JSON.dump(body))
        .to_return(status: 200,
                   body: JSON.dump(api_response),
                   headers: { content_type: 'application/json' })
    end

    it 'executes a CREATE request on the App Store Connect API and returns the response body with symbolized keys' do
      response = client.create '/test/endpoint', attribute: 'value'
      expect(response).to eq data: 'response'
    end

    context 'when the body contains snake case attributes' do
      let(:body) { { whatsNew: 'value' } }

      it 'transforms the attributes into camelCase format' do
        response = client.create '/test/endpoint', whats_new: 'value'
        expect(response).to eq data: 'response'
      end
    end

    context 'when the response contains camelCase fields' do
      let(:api_response) { { reviewSubmission: { data: { id: 'some-id' } } } }

      it 'transforms camelCase keys into snake_case' do
        response = client.create '/test/endpoint', attribute: 'value'
        expect(response).to eq review_submission: { data: { id: 'some-id' } }
      end
    end
  end

  describe '#patch' do
    let(:body) { { attribute: 'value' } }
    let(:api_response) { { data: 'response' } }

    before do
      stub_request(:patch, 'https://api.appstoreconnect.apple.com/test/endpoint')
        .with(headers: { authorization: 'Bearer bearer-token',
                         content_type: 'application/json' },
              body: JSON.dump(body))
        .to_return(status: 200,
                   body: JSON.dump(api_response),
                   headers: { content_type: 'application/json' })
    end

    it 'executes a PATCH request on the App Store Connect API and returns the response body with symbolized keys' do
      response = client.patch '/test/endpoint', attribute: 'value'
      expect(response).to eq data: 'response'
    end

    context 'when the body contains snake case attributes' do
      let(:body) { { whatsNew: 'value' } }

      it 'transforms the attributes into camelCase format' do
        response = client.patch '/test/endpoint', whats_new: 'value'
        expect(response).to eq data: 'response'
      end
    end

    context 'when the response contains camelCase fields' do
      let(:api_response) { { reviewSubmission: { data: { id: 'some-id' } } } }

      it 'transforms camelCase keys into snake_case' do
        response = client.patch '/test/endpoint', attribute: 'value'
        expect(response).to eq review_submission: { data: { id: 'some-id' } }
      end
    end
  end

  describe '#delete' do
    let(:api_response) { { data: 'response' } }

    before do
      stub_request(:delete, 'https://api.appstoreconnect.apple.com/test/endpoint')
        .with(headers: { authorization: 'Bearer bearer-token' })
        .to_return(status: 200,
                   body: JSON.dump(api_response),
                   headers: { content_type: 'application/json' })
    end

    it 'executes a DELETE request on the App Store Connect API and returns the response body with symbolized keys' do
      response = client.delete '/test/endpoint'
      expect(response).to eq data: 'response'
    end

    context 'when the response contains camelCase fields' do
      let(:api_response) { { reviewSubmission: { data: { id: 'some-id' } } } }

      it 'transforms camelCase keys into snake_case' do
        response = client.delete '/test/endpoint'
        expect(response).to eq review_submission: { data: { id: 'some-id' } }
      end
    end
  end
end
