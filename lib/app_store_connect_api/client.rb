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

    def initialize(issuer_id, key_id, private_key, request_timeout = 30)
      @authorization = Authorization.new issuer_id, key_id, private_key
      @request_timeout = request_timeout
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
      @connection ||= Faraday.new(url: APP_STORE_CONNECT_API_ROOT_URL,
                                  request: { timeout: @request_timeout },
                                  headers: { 'Authorization' => "Bearer #{@authorization.token}" }) do |f|

        f.request :retry,
                  max: 3,
                  interval: 1,
                  interval_randomness: 0.2,
                  backoff_factor: 1.5,
                  methods: %i[post delete get patch put],
                  retry_statuses: [429, 500, 502, 503, 504],
                  exceptions: Faraday::Retry::Middleware::DEFAULT_EXCEPTIONS + [Faraday::ConnectionFailed]
        f.request :json
        f.response :json, content_type: /\bjson$/
      end
    end
  end
end
