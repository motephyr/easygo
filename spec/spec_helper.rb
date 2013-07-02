require 'simplecov'
SimpleCov.start

require 'em-synchrony/em-http'
require 'goliath/test_helper'
require 'yajl/json_gem'
$:.unshift File.expand_path('../..', __FILE__)
require 'server'

Goliath.env = :test

RSpec.configure do |c|
  c.include Goliath::TestHelper, :example_group => {
    :file_path => /spec\//
  }
end