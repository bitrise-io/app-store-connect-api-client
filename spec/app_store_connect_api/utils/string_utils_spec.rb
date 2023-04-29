# frozen_string_literal: true

RSpec.describe AppStoreConnectApi::Utils::StringUtils do
  describe '.camelize' do
    {
      'limit' => 'limit',
      'beta_tester' => 'betaTester',
      'app_store_version_phased_release' => 'appStoreVersionPhasedRelease'
    }.each do |original, expected|
      it "transforms '#{original}' into '#{expected}'" do
        expect(described_class.camelize(original)).to eq expected
      end
    end
  end

  describe '.underscore' do
    {
      'limit' => 'limit',
      'betaTester' => 'beta_tester',
      'appStoreVersionPhasedRelease' => 'app_store_version_phased_release'
    }.each do |original, expected|
      it "transforms '#{original}' into '#{expected}'" do
        expect(described_class.underscore(original)).to eq expected
      end
    end
  end

  describe '.pluralize' do
    {
      'build' => 'builds',
      'bundleIdCapability' => 'bundleIdCapabilities',
      'canvas' => 'canvases'
    }.each do |original, expected|
      it "transforms '#{original}' into '#{expected}'" do
        expect(described_class.pluralize(original)).to eq expected
      end
    end
  end
end
