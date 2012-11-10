source 'http://rubygems.org'

gem 'rails', '3.1.1'

gem 'mysql2' # for dev
gem 'pg' # for heroku

gem 'haml'

gem 'devise'

gem 'mini_magick'
gem 'carrierwave'

gem 'thin'

# asset pipeline
group :assets do
  gem 'sprockets'
  gem 'sass-rails', '~> 3.1.4'
  gem 'uglifier', '>= 1.0.3'
end

# js library of choice
gem 'jquery-rails'

# asynchronous work
gem 'resque', :require => 'resque/server'
gem 'resque-retry'

# dev
group :development, :test do
  gem 'ruby-debug19'
  gem 'launchy'
  gem 'rspec-rails', '~> 2.6'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'mock-server'
  # Pretty printed test output
  gem 'turn', :require => false
end

