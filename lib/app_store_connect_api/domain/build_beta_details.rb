# frozen_string_literal: true

module AppStoreConnectApi
  module Domain
    module BuildBetaDetails
      # @see https://developer.apple.com/documentation/appstoreconnectapi/list_build_beta_details
      def build_beta_details(options = {})
        get '/v1/buildBetaDetails', options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/read_build_beta_detail_information
      def build_beta_detail(build_beta_detail_id, options = {})
        get "/v1/buildBetaDetails/#{build_beta_detail_id}", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/modify_a_build_beta_detail
      def update_build_beta_detail(build_beta_detail_id, attributes)
        patch "/v1/buildBetaDetails/#{build_beta_detail_id}", data: { attributes: attributes,
                                                                      id: build_beta_detail_id,
                                                                      type: 'buildBetaDetails' }
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/read_the_build_information_of_a_build_beta_detail
      def build_beta_detail_build(build_beta_detail_id, options = {})
        get "/v1/buildBetaDetails/#{build_beta_detail_id}/build", options
      end
    end
  end
end
