# frozen_string_literal: true

RSpec.shared_context 'API requests' do # rubocop:disable RSpec/ContextWording
  let(:client) { AppStoreConnectApi::Client.new 'issuer-id', 'key-id', 'private-key' }
  let(:authorization) { instance_double AppStoreConnectApi::Authorization, token: 'bearer-token' }

  before do
    allow(AppStoreConnectApi::Authorization).to receive(:new).with('issuer-id', 'key-id', 'private-key').and_return authorization
  end

  shared_examples_for 'a GET endpoint' do |url:, query_params: {}|
    it 'calls the specified endpoint and returns the results' do
      stub_request(:get, url)
        .with(headers: { authorization: 'Bearer bearer-token' },
              query: query_params)
        .to_return(status: 200,
                   body: JSON.dump('data' => 'response'),
                   headers: { content_type: 'application/json' })
      expect(subject).to eq data: 'response'
    end
  end

  shared_examples_for 'a CREATE endpoint' do |url:, body:|
    it 'calls the specified endpoint and returns the results' do
      stub_request(:post, url)
        .with(headers: { authorization: 'Bearer bearer-token',
                         content_type: 'application/json' },
              body: body)
        .to_return(status: 200,
                   body: JSON.dump('data' => 'response'),
                   headers: { content_type: 'application/json' })
      expect(subject).to eq data: 'response'
    end
  end

  shared_examples_for 'a PATCH endpoint' do |url:, body:|
    it 'calls the specified endpoint and returns the results' do
      stub_request(:patch, url)
        .with(headers: { authorization: 'Bearer bearer-token',
                         content_type: 'application/json' },
              body: body)
        .to_return(status: 200,
                   body: JSON.dump('data' => 'response'),
                   headers: { content_type: 'application/json' })
      expect(subject).to eq data: 'response'
    end
  end

  shared_examples_for 'a DELETE endpoint' do |url:, body: {}|
    it 'calls the specified endpoint and returns the results' do
      if body.empty?
        stub_request(:delete, url)
          .with(headers: { authorization: 'Bearer bearer-token' })
          .to_return(status: 200,
                     body: JSON.dump('data' => 'response'),
                     headers: { content_type: 'application/json' })
      else
        stub_request(:delete, url)
          .with(headers: { authorization: 'Bearer bearer-token',
                           content_type: 'application/json' },
                body: body)
          .to_return(status: 200,
                     body: JSON.dump('data' => 'response'),
                     headers: { content_type: 'application/json' })
      end
      expect(subject).to eq data: 'response'
    end
  end
end
