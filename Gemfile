source "https://rubygems.org"

ruby "2.1.3"

# Bundle edge Rails instead: gem "rails", github: "rails/rails"
gem "rails"
# Enable token authentication
gem "has_secure_token"
# Enable JSON output
gem 'responders', '~> 2.0'
# Use PostgreSQL as database
gem "pg"
# Encapsulate the JSON serialization of objects. Read more: https://github.com/rails-api/active_model_serializers
gem "active_model_serializers"
# Memcached store cashe on server
gem "dalli"
# Authenticate with Email
gem "omniauth-identity"
# Authenticate with Facebook
gem "omniauth-facebook"
# Authorize what ressources a given user is allowed to access within your application
gem "pundit"
# Track user activity. Read more: https://mixpanel.com/help/reference/ruby
gem "mixpanel-ruby"
# Enable payment options
gem "braintree"
# Handle unit measurement conversion
gem "unitwise"
# Monitor Ruby gems to be up-to-date
gem "gemsurance"
# Provide cross-origin resource sharing
gem "rack-cors", :require => "rack/cors"

gem "paperclip"
gem "aws-sdk"

group :doc do
  # Bundle exec rake doc:rails generates the API under doc/api.
  gem "sdoc", "~> 0.4.0"
end

group :development, :test do
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"
  # Handle error requests for debugging
  gem "meta_request"
  # Monitor application performance
  gem "bullet"
  # Display json objects pretty
  gem "awesome_print"
  # Write test scripts. Read more: http://github.com/rspec/rspec
  gem "factory_girl_rails"
  gem "rspec-rails"
  # Debug source code
  gem "byebug"
  gem "pry-rails"
  gem "quiet_assets"
end

group :production do
  # Use Puma as web server
  gem "puma"
  # Use Uglifier as compressor for JavaScript assets
  gem "uglifier", ">= 1.3.0"
  # Enable Heroku features
  gem "rails_12factor"
end
