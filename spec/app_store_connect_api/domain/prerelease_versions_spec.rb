# frozen_string_literal: true

RSpec.describe AppStoreConnectApi::Domain::PrereleaseVersions, :api do
  describe '#prerelease_versions' do
    subject { client.prerelease_versions limit: 10 }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/preReleaseVersions',
                                      query_params: { limit: 10 }
  end

  describe '#prerelease_version' do
    subject { client.prerelease_version 'prerelease-version-id', include: 'app' }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/preReleaseVersions/prerelease-version-id',
                                      query_params: { include: 'app' }
  end

  describe '#prerelease_version_app' do
    subject { client.prerelease_version_app 'prerelease-version-id', fields: { apps: 'bundleId' } }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/preReleaseVersions/prerelease-version-id/app',
                                      query_params: { fields: { apps: 'bundleId' } }
  end

  describe '#prerelease_version_builds' do
    subject { client.prerelease_version_builds 'prerelease-version-id', limit: 10 }

    it_behaves_like 'a GET endpoint', url: 'https://api.appstoreconnect.apple.com/v1/preReleaseVersions/prerelease-version-id/builds',
                                      query_params: { limit: 10 }
  end
end
