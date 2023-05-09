# frozen_string_literal: true

module AppStoreConnectApi
  module Domain
    module CustomerReviews
      # @see https://developer.apple.com/documentation/appstoreconnectapi/read_customer_review_information
      def customer_review(customer_review_id, options = {})
        get "/v1/customerReviews/#{customer_review_id}", options
      end
    end
  end
end
