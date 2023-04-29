# frozen_string_literal: true

require 'openssl'
require 'jwt'
require 'faraday'
require_relative "app_store_connect_api/client"
require_relative "app_store_connect_api/version"

module AppStoreConnectApi
  class Error < StandardError; end

  class ApiError < Error
    attr_reader :errors

    def initialize(errors)
      @errors = errors
      super 'App Store Connect API request failed'
    end

    def code
      errors.first[:code]
    end

    def status
      errors.first[:status].to_i
    end
  end
end
