# frozen_string_literal: true

module AppStoreConnectApi
  module Utils
    module HashUtils
      class << self
        def deep_transform_keys(object, &block)
          return object unless object.is_a? Hash

          object.each_with_object({}) do |(key, value), result|
            result[yield(key)] = deep_transform_keys value, &block
          end
        end
      end
    end
  end
end
