# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.3'

# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'

# Use Puma as the app server
gem 'puma', '~> 4.1'

# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'foreman'
gem 'webpacker', '~> 4.0'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

# Scraping
gem 'nokogiri', '~> 1.10'

# Background Jobs
gem 'redis-rails'
gem 'sidekiq', '6.0.7'

# Different
gem 'therubyracer', platforms: :ruby

# Rules for migrations
gem 'strong_migrations'

# serialization
gem 'fast_jsonapi'

# localize
gem 'route_translator', '~> 8.0'

group :development, :test do
  gem 'database_cleaner'
  # Spec
  gem 'factory_bot_rails'
  gem 'rspec-rails'
  # Static analysis
  gem 'brakeman', require: false
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
  # N+1 query detector
  gem 'bullet'
end

group :development do
  gem 'listen', '~> 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'json_spec'
  gem 'rails-controller-testing'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
end
