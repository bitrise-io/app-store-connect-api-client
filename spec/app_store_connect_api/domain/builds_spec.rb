# frozen_string_literal: true

RSpec.describe AppStoreConnectApi::Domain::Builds, :api do
  describe '#builds' do
    subject { client.builds limit: 10 }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/builds',
                                      query_params: { limit: 10 }
  end

  describe '#build' do
    subject { client.build 'build-id', include: 'appStoreVersion' }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/builds/build-id',
                                      query_params: { include: 'appStoreVersion' }
  end

  describe '#update_build' do
    subject { client.update_build 'build-id', { uses_non_exempt_encryption: false }, app_encryption_declaration: 'app-encryption-declaration-id' }

    it_behaves_like 'a PATCH endpoint', url: 'https://api.appstoreconnect.apple.com/v1/builds/build-id',
                                        body: {
                                          data: { attributes: { usesNonExemptEncryption: false },
                                                  relationships: { appEncryptionDeclaration: { data: { id: 'app-encryption-declaration-id', type: 'appEncryptionDeclarations' } } },
                                                  id: 'build-id',
                                                  type: 'builds' }
                                        }
  end

  describe '#build_app' do
    subject { client.build_app 'build-id', fields: { apps: 'name' } }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/builds/build-id/app',
                                      query_params: { fields: { apps: 'name' } }
  end

  describe '#build_app_encryption_declaration' do
    subject { client.build_app_encryption_declaration 'build-id', fields: { app_encryption_declarations: 'app' } }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/builds/build-id/appEncryptionDeclaration',
                                      query_params: { fields: { appEncryptionDeclarations: 'app' } }
  end

  describe '#build_app_encryption_declaration_id' do
    subject { client.build_app_encryption_declaration_id 'build-id' }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/builds/build-id/relationships/appEncryptionDeclaration'
  end

  describe '#build_app_store_version' do
    subject { client.build_app_store_version 'build-id', include: 'app' }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/builds/build-id/appStoreVersion',
                                      query_params: { include: 'app' }
  end

  describe '#build_beta_app_review_submission' do
    subject { client.build_beta_app_review_submission 'build-id', fields: { beta_app_review_submissions: 'build' } }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/builds/build-id/betaAppReviewSubmission',
                                      query_params: { fields: { betaAppReviewSubmissions: 'build' } }
  end

  describe '#build_beta_build_localizations' do
    subject { client.build_beta_build_localizations 'build-id', limit: 10 }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/builds/build-id/betaBuildLocalizations',
                                      query_params: { limit: 10 }
  end

  describe '#build_build_beta_detail' do
    subject { client.build_build_beta_detail 'build-id', fields: { build_beta_details: 'build' } }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/builds/build-id/buildBetaDetail',
                                      query_params: { fields: { buildBetaDetails: 'build' } }
  end

  describe '#add_build_beta_groups' do
    subject { client.add_build_beta_groups 'build-id', ['beta-group-id1', 'beta-group-id2'] }

    it_behaves_like 'a POST endpoint', url: 'https://api.appstoreconnect.apple.com/v1/builds/build-id/relationships/betaGroups',
                                       body: {
                                         data: [{ id: 'beta-group-id1', type: 'betaGroups' },
                                                { id: 'beta-group-id2', type: 'betaGroups' }]
                                       }
  end

  describe '#remove_build_beta_groups' do
    subject { client.remove_build_beta_groups 'build-id', ['beta-group-id1', 'beta-group-id2'] }

    it_behaves_like 'a DELETE endpoint', url: 'https://api.appstoreconnect.apple.com/v1/builds/build-id/relationships/betaGroups',
                                         body: {
                                           data: [{ id: 'beta-group-id1', type: 'betaGroups' },
                                                  { id: 'beta-group-id2', type: 'betaGroups' }]
                                         }
  end

  describe '#build_individual_testers' do
    subject { client.build_individual_testers 'build-id', limit: 10 }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/builds/build-id/individualTesters',
                                      query_params: { limit: 10 }
  end

  describe '#build_individual_tester_ids' do
    subject { client.build_individual_tester_ids 'build-id', limit: 10 }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/builds/build-id/relationships/individualTesters',
                                      query_params: { limit: 10 }
  end

  describe '#add_build_individual_testers' do
    subject { client.add_build_individual_testers 'build-id', ['beta-tester-id1', 'beta-tester-id2'] }

    it_behaves_like 'a POST endpoint', url: 'https://api.appstoreconnect.apple.com/v1/builds/build-id/relationships/individualTesters',
                                       body: {
                                         data: [{ id: 'beta-tester-id1', type: 'betaTesters' },
                                                { id: 'beta-tester-id2', type: 'betaTesters' }]
                                       }
  end

  describe '#remove_build_individual_testers' do
    subject { client.remove_build_individual_testers 'build-id', ['beta-tester-id1', 'beta-tester-id2'] }

    it_behaves_like 'a DELETE endpoint', url: 'https://api.appstoreconnect.apple.com/v1/builds/build-id/relationships/individualTesters',
                                         body: {
                                           data: [{ id: 'beta-tester-id1', type: 'betaTesters' },
                                                  { id: 'beta-tester-id2', type: 'betaTesters' }]
                                         }
  end

  describe '#build_prerelease_version' do
    subject { client.build_prerelease_version 'build-id', fields: { pre_release_versions: 'version' } }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/builds/build-id/preReleaseVersion',
                                      query_params: { fields: { preReleaseVersions: 'version' } }
  end

  describe '#build_icons' do
    subject { client.build_icons 'build-id', limit: 10 }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/builds/build-id/icons',
                                      query_params: { limit: 10 }
  end
end
