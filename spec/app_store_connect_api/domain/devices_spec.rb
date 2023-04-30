# frozen_string_literal: true

RSpec.describe AppStoreConnectApi::Domain::Devices, :api do
  describe '#devices' do
    subject { client.devices limit: 10 }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/devices',
                                      query_params: { limit: 10 }
  end

  describe '#device' do
    subject { client.device 'device-id', fields: { devices: 'name' } }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/devices/device-id',
                                      query_params: { fields: { devices: 'name' } }
  end

  describe '#create_device' do
    subject { client.create_device name: 'Device name', platform: 'IOS', udid: 'id' }

    it_behaves_like 'a POST endpoint', url: 'https://api.appstoreconnect.apple.com/v1/devices',
                                       body: {
                                         data: { attributes: { name: 'Device name', platform: 'IOS', udid: 'id' },
                                                 type: 'devices' }
                                       }
  end

  describe '#update_device' do
    subject { client.update_device 'device-id', name: 'New name' }

    it_behaves_like 'a PATCH endpoint', url: 'https://api.appstoreconnect.apple.com/v1/devices/device-id',
                                        body: {
                                          data: { attributes: { name: 'New name' },
                                                  id: 'device-id',
                                                  type: 'devices' }
                                        }
  end
end
