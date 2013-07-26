source "http://rubygems.org"

gem "goliath"

#html
gem "haml"
#gem "tilt"
gem "coffee-script"

gem "grape"
#C's json Parser
gem 'yajl-ruby',platform: :ruby

#MQ
gem 'jruby-jms',platform: :jruby

#postgres
gem 'activerecord-jdbcpostgresql-adapter',platform: :jruby
gem 'activerecord-jdbc-adapter',platform: :jruby
gem 'pg',platform: :ruby
gem 'em-postgresql-adapter', :git => 'git://github.com/leftbee/em-postgresql-adapter.git',platform: :ruby

gem 'rack-fiber_pool',  :require => 'rack/fiber_pool'
gem 'em-synchrony', :require => 'em-synchrony'
gem 'activerecord', '~>3.2.14'

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

