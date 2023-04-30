# frozen_string_literal: true

RSpec.describe AppStoreConnectApi::Domain::Certificates, :api do
  describe '#certificates' do
    subject { client.certificates limit: 10 }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/certificates',
                                      query_params: { limit: 10 }
  end

  describe '#certificate' do
    subject { client.certificate 'certificate-id', fields: { certificates: 'name' } }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/certificates/certificate-id',
                                      query_params: { fields: { certificates: 'name' } }
  end

  describe '#create_certificate' do
    subject { client.create_certificate certificate_type: 'IOS_DEVELOPMENT', csr_content: 'content' }

    it_behaves_like 'a POST endpoint', url: 'https://api.appstoreconnect.apple.com/v1/certificates',
                                       body: {
                                         data: { attributes: { certificateType: 'IOS_DEVELOPMENT', csrContent: 'content' },
                                                 type: 'certificates' }
                                       }
  end

  describe '#delete_certificate' do
    subject { client.delete_certificate 'certificate-id' }

    it_behaves_like 'a DELETE endpoint', url: 'https://api.appstoreconnect.apple.com/v1/certificates/certificate-id'
  end
end
