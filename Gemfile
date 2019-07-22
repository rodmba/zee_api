# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.6.3"

gem "bootsnap", ">= 1.1.0", require: false
gem "pg", ">= 0.18", "< 2.0"
gem "puma", "~> 3.11"
gem "rails", "~> 5.2.3"

# auth
gem "bcrypt", "~> 3.1.7"
gem "jwt"

group :development, :test do
  gem "dotenv-rails", "~> 2.7.4"
  gem "factory_bot_rails", "~> 4.8.2"
end

group :development do
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "rubocop", require: false
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

group :test do
  gem "rspec", "~> 3.7.0"
  gem "rspec-rails", "~> 3.7.2"
  gem "rspec_junit_formatter"
end
