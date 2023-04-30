# frozen_string_literal: true

module AppStoreConnectApi
  module Domain
    module Devices
      # @see https://developer.apple.com/documentation/appstoreconnectapi/list_devices
      def devices(options = {})
        get '/v1/devices', options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/read_device_information
      def device(device_id, options = {})
        get "/v1/devices/#{device_id}", options
      end

      # @see https://developer.apple.com/documentation/appstoreconnectapi/register_a_new_device
      def create_device(attributes)
        create '/v1/devices', data: { attributes: attributes,
                                      type: 'devices' }
      end
      alias :register_device :create_device

      # @see https://developer.apple.com/documentation/appstoreconnectapi/modify_a_registered_device
      def update_device(device_id, attributes)
        patch "/v1/devices/#{device_id}", data: { attributes: attributes,
                                                  id: device_id,
                                                  type: 'devices' }
      end
    end
  end
end
