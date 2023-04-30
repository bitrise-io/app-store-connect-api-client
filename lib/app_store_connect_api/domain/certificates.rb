# frozen_string_literal: true

module AppStoreConnectApi
  module Domain
    module Certificates
      # @see https://developer.apple.com/documentation/appstoreconnectapi/list_and_download_certificates
      def certificates(options = {})
        get '/v1/certificates', options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/read_and_download_certificate_information
      def certificate(certificate_id, options = {})
        get "/v1/certificates/#{certificate_id}", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/create_a_certificate
      def create_certificate(attributes)
        post '/v1/certificates', data: { attributes: attributes,
                                         type: 'certificates' }
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/revoke_a_certificate
      def delete_certificate(certificate_id)
        delete "/v1/certificates/#{certificate_id}"
      end
      alias :revoke_certificate :delete_certificate
    end
  end
end
