# frozen_string_literal: true

require_relative 'authorization'
require_relative 'domain'
require_relative 'response'
require_relative 'utils/hash_utils'
require_relative 'utils/relationship_mapper'
require_relative 'utils/string_utils'

module AppStoreConnectApi
  class Client
    include Domain

    APP_STORE_CONNECT_API_ROOT_URL = 'https://api.appstoreconnect.apple.com'
    APP_STORE_CONNECT_ENTERPRISE_API_ROOT_URL = 'https://api.enterprise.developer.apple.com/'

    def initialize(issuer_id, key_id, private_key, request_timeout = 30, is_enterprise_account = false)
      @authorization = Authorization.new issuer_id, key_id, private_key, is_enterprise_account: is_enterprise_account
      @request_timeout = request_timeout
      @is_enterprise_account = is_enterprise_account
    end

    def get(path, options = {})
      call_api :get, path, options
    end

    def post(path, body)
      call_api :post, path, {}, body
    end

    def patch(path, body)
      call_api :patch, path, {}, body
    end

    def delete(path, body = {})
      call_api :delete, path, {}, body
    end

    def more?(resource)
      not link_to_next_page_in(resource).nil?
    end

    def next(resource)
      call_api :get, link_to_next_page_in(resource).sub(APP_STORE_CONNECT_API_ROOT_URL, '')
    end

    private

    def link_to_next_page_in(response)
      response.dig(:links, :next)
    end

    def call_api(method, path, params = {}, payload = {})
      response = connection.send(method, path) do |req|
        req.params = camel_case(params) unless params.empty?
        req.body = camel_case(payload) unless payload.empty?
      end

      Response.new(response.body, params[:include]).response
    rescue Faraday::Error => error
      raise Error, error
    end

    def camel_case(params)
      Utils::HashUtils.deep_transform_keys(params) { |key| Utils::StringUtils.camelize key.to_s }
    end

    def connection
      @connection ||= Faraday.new(url: base_url,
                                  request: { timeout: @request_timeout },
                                  headers: { 'Authorization' => "Bearer #{@authorization.token}" }) do |f|
        f.request :retry,
                  max: 3,
                  interval: 1,
                  interval_randomness: 0.2,
                  backoff_factor: 1.5,
                  # Updated based on the official recommendation: https://github.com/lostisland/faraday-retry?tab=readme-ov-file#specify-a-custom-retry-logic
                  methods: [],
                  retry_statuses: [408, 429, 500, 502, 503, 504],
                  retry_if: ->(env, _exc) { [408, 429, 502, 503, 504].include?(env.status) || (env.status == 500 && env.body.to_s.include?('UNEXPECTED_ERROR')) },
                  exceptions: Faraday::Retry::Middleware::DEFAULT_EXCEPTIONS + [Faraday::ConnectionFailed]
        f.request :json
        f.response :json, content_type: /\bjson$/
      end
    end

    def base_url
      if @is_enterprise_account
        APP_STORE_CONNECT_ENTERPRISE_API_ROOT_URL
      else
        APP_STORE_CONNECT_API_ROOT_URL
      end
    end
  end
end
