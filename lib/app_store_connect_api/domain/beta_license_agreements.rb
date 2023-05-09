# frozen_string_literal: true

module AppStoreConnectApi
  module Domain
    module BetaLicenseAgreements
      # @see https://developer.apple.com/documentation/appstoreconnectapi/list_beta_license_agreements
      def beta_license_agreements(options = {})
        get '/v1/betaLicenseAgreements', options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/read_beta_license_agreement_information
      def beta_license_agreement(beta_license_agreement_id, options = {})
        get "/v1/betaLicenseAgreements/#{beta_license_agreement_id}", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/modify_a_beta_license_agreement
      def update_beta_license_agreement(beta_license_agreement_id, attributes)
        patch "/v1/betaLicenseAgreements/#{beta_license_agreement_id}", data: { attributes: attributes,
                                                                                id: beta_license_agreement_id,
                                                                                type: 'betaLicenseAgreements' }
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/read_the_app_information_of_a_beta_license_agreement
      def beta_license_agreement_app(beta_license_agreement_id, options = {})
        get "/v1/betaLicenseAgreements/#{beta_license_agreement_id}/app", options
      end
    end
  end
end
