# frozen_string_literal: true

RSpec.describe AppStoreConnectApi::Authorization do
  subject(:auth) { described_class.new 'issuer-id', 'key-id', 'encoded-private-key' }

  describe '#token', :freeze_time do
    it 'returns a JWT token' do
      allow(OpenSSL::PKey).to receive(:read).with('encoded-private-key').and_return 'private-key'
      allow(JWT).to receive(:encode).with({ iss: 'issuer-id',
                                            iat: Time.now.to_i,
                                            exp: Time.now.to_i + 1200,
                                            aud: 'appstoreconnect-v1' },
                                          'private-key',
                                          'ES256',
                                          { kid: 'key-id' }).and_return 'JWT token'
      expect(auth.token).to eq 'JWT token'
    end
  end
end
