source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.1'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 3.1.6'

# Twitter bootstrap
gem 'bootstrap-sass'

#Paperclip for the user to upload files
gem 'paperclip', "~> 3.0"

#Rambling slider for image carousel
# gem 'rambling-slider-rails', :git => 'https://github.com/gonzedge/rambling-slider-rails'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails'

# Devise for user authentication
gem "devise", "~> 2.2.8"

#gridster for showing some works
gem 'gridster-rails', :git => 'git@github.com:Hank-Roughknuckles/gridster-rails.git'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :development, :test do
  gem 'sqlite3', '1.3.8'
  gem 'rspec-rails', '2.13.1'
  gem 'rb-fsevent', :require => false if RUBY_PLATFORM =~ /darwin/i
  gem "spork", "> 0.9.0.rc"
  gem 'guard-rspec'
  gem "guard-spork"
end

group :test do
  gem 'selenium-webdriver', '2.35.1'
  gem 'factory_girl_rails'
  gem 'capybara', '2.1.0'
  gem 'database_cleaner'
end

group :production do
  gem 'pg', '0.15.1'
  gem 'rails_12factor', '0.0.2'
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
