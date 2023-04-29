# frozen_string_literal: true

module AppStoreConnectApi
  module Utils
    module HashUtils
      class << self
        def deep_transform_keys(object, &block)
          case object
          when Hash
            object.each_with_object({}) do |(key, value), result|
              result[yield(key)] = deep_transform_keys value, &block
            end
          when Array
            object.map { |item| deep_transform_keys item, &block }
          else
            object
          end
        end
      end
    end
  end
end
