# frozen_string_literal: true

module AppStoreConnectApi
  class Authorization
    ALGORITHM = 'ES256'

    def initialize(issuer_id, key_id, private_key)
      @issuer_id = issuer_id
      @key_id = key_id
      @private_key = private_key
    end

    def token
      JWT.encode payload, private_key, ALGORITHM, header_fields
    end

    private

    def payload
      {
        iss: @issuer_id,
        iat: Time.now.to_i,
        exp: Time.now.to_i + (20 * 60),
        aud: 'appstoreconnect-v1'
      }
    end

    def private_key
      OpenSSL::PKey.read @private_key
    end

    def header_fields
      { kid: @key_id }
    end
  end
end
