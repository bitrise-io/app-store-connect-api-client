# frozen_string_literal: true

module AppStoreConnectApi
  class Authorization
    TEST = 'VAR'
    ALGORITHM = 'ES256'
    TOKEN_AUDIENCE = "appstoreconnect-v1"
    TOKEN_ENTERPRISE_AUDIENCE = "apple-developer-enterprise-v1"

    def initialize(issuer_id, key_id, private_key, is_enterprise_account: false)
      @issuer_id = issuer_id
      @key_id = key_id
      @private_key = private_key
      @is_enterprise_account = is_enterprise_account
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
        aud: if @is_enterprise_account
               TOKEN_ENTERPRISE_AUDIENCE
             else
               TOKEN_AUDIENCE
             end
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
