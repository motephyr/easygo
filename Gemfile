source "http://rubygems.org"

gem "goliath"

#html
gem "haml"
#gem "tilt"
gem "coffee-script"

gem "grape"
#C's json Parser
gem 'yajl-ruby'

#postgres
gem 'pg'
gem 'em-postgresql-adapter', :git => 'git://github.com/leftbee/em-postgresql-adapter.git'
gem 'rack-fiber_pool',  :require => 'rack/fiber_pool'
gem 'em-synchrony', :require => 'em-synchrony'
gem 'activerecord', '~>3.1.0'

#debug
gem "pry"
gem "pry-nav"

group :test, :development do
  gem "rspec", "~> 2.0"
  gem 'em-http-request'

  gem 'guard'
  gem 'guard-rspec'

  gem 'simplecov'
  gem 'rack-test'
end

