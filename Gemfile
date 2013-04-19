source 'https://rubygems.org'


gem 'rails', '3.2.12'
gem 'execjs'
gem 'therubyracer'

gem 'childprocess', '0.3.6'
gem 'devise'
gem 'httparty', '0.10.2'
gem 'event-calendar', :require => 'event_calendar'
gem 'jquery-timepicker-rails'
gem 'jquery_datepicker'

group :development, :test do
  #gem 'pg', '0.12.2'
  gem 'sqlite3'
  #gem 'rspec-rails', '2.11.0'
  gem 'rspec-rails'
  gem 'guard-rspec', '1.2.1'

  gem 'guard-spork', '1.2.0'
  gem 'spork', '0.9.2'

  #for test coverage
  gem 'rcov', '0.9.8'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '3.2.5'
  gem 'coffee-rails', '3.2.2'
  gem 'uglifier', '1.2.3'
end

gem 'jquery-rails', '2.0.2'
gem 'jquery-ui-rails'

group :test do
  gem 'capybara'
  gem 'rspec-rails'
  # for Linux
  gem 'rb-inotify', '0.9'
  # for Mac
  gem 'rb-fsevent', '0.9.1', :require => false
  gem 'growl', '1.0.3'
end

group :production do
  gem 'pg', '0.12.2'
end
