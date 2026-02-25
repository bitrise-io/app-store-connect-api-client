# frozen_string_literal: true

module AppStoreConnectApi
  module Domain
    module AppStoreVersionSubmissions
      # @see https://developer.apple.com/documentation/appstoreconnectapi/delete-v1-appstoreversionsubmissions-_id_
      def delete_app_store_version_submission(app_store_version_id)
        delete "/v1/appStoreVersionSubmissions/#{app_store_version_id}"
      end
    end
  end
end
