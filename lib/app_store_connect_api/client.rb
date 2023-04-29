# frozen_string_literal: true

require_relative 'authorization'
require_relative 'utils/hash_utils'
require_relative 'utils/relationship_mapper'
require_relative 'utils/string_utils'
require_relative 'client/app_store_version_localizations'
require_relative 'client/app_store_version_phased_releases'
require_relative 'client/app_store_version_release_requests'
require_relative 'client/app_store_versions'
require_relative 'client/apps'
require_relative 'client/beta_app_review_submissions'
require_relative 'client/beta_build_localizations'
require_relative 'client/beta_groups'
require_relative 'client/beta_tester_invitations'
require_relative 'client/beta_testers'
require_relative 'client/build_beta_details'
require_relative 'client/builds'
require_relative 'client/review_submission_items'
require_relative 'client/review_submissions'

module AppStoreConnectApi
  class Client
    include AppStoreVersionLocalizations
    include AppStoreVersionPhasedReleases
    include AppStoreVersionReleaseRequests
    include AppStoreVersions
    include Apps
    include BetaAppReviewSubmissions
    include BetaBuildLocalizations
    include BetaGroups
    include BetaTesterInvitations
    include BetaTesters
    include BuildBetaDetails
    include Builds
    include ReviewSubmissionItems
    include ReviewSubmissions

    APP_STORE_CONNECT_API_ROOT_URL = 'https://api.appstoreconnect.apple.com'

    def initialize(issuer_id, key_id, private_key)
      @authorization = Authorization.new issuer_id, key_id, private_key
    end

    def get(path, options = {})
      call_api :get, path, options
    end

    def create(path, body)
      call_api :post, path, {}, body
    end

    def patch(path, body)
      call_api :patch, path, {}, body
    end

    def delete(path, body = {})
      call_api :delete, path, {}, body
    end

    private

    def call_api(method, path, params = {}, payload = {})
      response = connection.send(method, path) do |req|
        req.params = camel_case(params) unless params.empty?
        req.body = camel_case(payload) unless payload.empty?
      end
      result = snake_case response.body
      process_response response, result
    rescue Faraday::Error => error
      raise Error, error
    end

    def process_response(response, result)
      if response.success?
        result
      elsif result.respond_to? :fetch
        raise ApiError, result.fetch(:errors, [])
      else
        raise Error, result
      end
    end

    def camel_case(params)
      Utils::HashUtils.deep_transform_keys(params) { |key| Utils::StringUtils.camelize key.to_s }
    end

    def snake_case(response)
      if response.is_a? Hash
        Utils::HashUtils.deep_transform_keys(response) { |key| Utils::StringUtils.underscore(key).to_sym }
      else
        response
      end
    end

    def connection
      @connection ||= Faraday.new(url: APP_STORE_CONNECT_API_ROOT_URL,
                                  request: { timeout: 3 },
                                  headers: { 'Authorization' => "Bearer #{@authorization.token}" }) do |f|
        f.request :json
        f.response :json, content_type: /\bjson$/
        f.adapter :net_http
      end
    end
  end
end
