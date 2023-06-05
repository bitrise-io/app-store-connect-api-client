# frozen_string_literal: true

require_relative "lib/app_store_connect_api/version"

Gem::Specification.new do |spec|
  spec.name = "app_store_connect_api_client"
  spec.version = AppStoreConnectApi::VERSION
  spec.authors = ["Zoltan Ormandi"]
  spec.email = ["zoltan.ormandi@gmail.com"]

  spec.summary = "A Ruby client for the App Store Connect API"
  spec.description = "A thin Ruby wrapper around the App Store Connect API to provide a more convenient way of accessing App Store Connect."
  spec.homepage = "https://github.com/zormandi/app_store_connect_api.rb"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.7.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/zormandi/app_store_connect_api.rb"
  spec.metadata["changelog_uri"] = "https://github.com/zormandi/app_store_connect_api.rb/blob/main/CHANGELOG.md"
  spec.metadata['rubygems_mfa_required'] = 'true'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday"
  spec.add_dependency "jwt", "~> 2.0"

  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubocop", "~> 1.50"
  spec.add_development_dependency "rubocop-rspec", "~> 2.22"
  spec.add_development_dependency "webmock", "~> 3.0"
end
