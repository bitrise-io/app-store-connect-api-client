# App Store Connect API client for Ruby

[![Build Status](https://github.com/zormandi/app_store_connect_api.rb/actions/workflows/main.yml/badge.svg)](https://github.com/zormandi/app_store_connect_api.rb/actions/workflows/main.yml)
[![Gem Version](https://badge.fury.io/rb/app_store_connect_api_client.svg)](https://badge.fury.io/rb/app_store_connect_api_client)

This gem provides a thin Ruby wrapper around the [App Store Connect API](https://developer.apple.com/documentation/appstoreconnectapi) to make accessing App Store Connect more convenient and to help automate your Apple workflows.

It does not cover the complete domain of the App Store Connect API (yet), but
- it does cover the most commonly used APIs,
- it is robust and thoroughly tested,
- it's easy to understand and extend as it contains no metaprogramming (which also means you can have auto-completion with an IDE).

The list of supported domains can be found in the project's [domain folder](https://github.com/zormandi/app_store_connect_api.rb/blob/main/lib/app_store_connect_api/domain).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'app_store_connect_api'
```

and run:

```bash
$ bundle install
```

## Usage

```ruby
client = AppStoreConnectAPI::Client.new '<issuer ID>', '<key ID>', '<path to private key>'

# Simple query
client.apps filter: { bundle_id: 'company.org' }, limit: 5

# Including other resources
client.app_app_store_versions '1539394316', 
                              filter: { platform: 'IOS', version_string: '2.2' }, 
                              include: 'appStoreVersionPhasedRelease,appStoreVersionLocalizations'

# Pagination
apps = client.apps limit: 10
while client.more? apps
  apps = client.next apps
end

# Creating a resource
client.create_bundle_id identifier: 'id.bundle', name: 'Name', platform: 'IOS'

# Creating a resource with a relationship
app_store_version_attributes = {
  version_string: '1.2',
  platform: 'IOS',
  # ...
}
client.create_app_store_version(app_store_version_attributes, app: '<app-id>') # Using the shorthand syntax for specifying relationships
client.create_app_store_version(app_store_version_attributes, app: { data: { id: '<app-id>', type: 'apps' } }) # Using the full relationship syntax

# Creating a resource with no attributes, just relationships
client.create_review_submission_item review_submission: '<review-submission-id>', app_store_version: '<app-store-version-id>'

# Updating attributes
client.update_app_store_version '<app-store-version-id>', version_string: '1.3'

# Updating attributes and relationships at the same time
client.update_app_store_version '<app-store-version-id>', { version_string: '1.3' }, build: '<build-id>'

# Deleting a resource
client.delete_app_store_version '<app-store-version-id>'

# Some endpoints expect an array of relationships 
client.add_build_beta_groups '<build-id>', ['<beta-group-id1>', '<beta-group-id2>'] # Using the shorthand syntax for specifying relationships
client.add_build_beta_groups '<build-id>', [{ id: 'beta-group-id1', type: 'betaGroups' },
                                            { id: 'beta-group-id2', type: 'betaGroups' }] # Using the full relationship syntax
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/zormandi/app_store_connect_api.rb. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/zormandi/app_store_connect_api.rb/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in this project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/zormandi/app_store_connect_api.rb/blob/main/CODE_OF_CONDUCT.md).
