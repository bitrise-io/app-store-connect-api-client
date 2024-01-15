# frozen_string_literal: true

require 'openssl'
require 'jwt'
require 'faraday'
require 'faraday/retry'
require_relative "app_store_connect_api/client"
require_relative "app_store_connect_api/version"

module AppStoreConnectApi
  class Error < StandardError; end
end
