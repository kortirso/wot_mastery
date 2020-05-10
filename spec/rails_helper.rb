# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../config/environment', __dir__)

abort('The Rails environment is running in production mode!') if Rails.env.production?

require 'spec_helper'
require 'rspec/rails'
require 'sidekiq/testing'

Sidekiq::Testing.fake!

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

# rubocop: disable Lint/NonDeterministicRequireOrder
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }
# rubocop: enable Lint/NonDeterministicRequireOrder

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
