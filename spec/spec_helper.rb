require 'bundler'

Bundler.setup
Bundler.require

require 'em-synchrony/em-http'
require 'goliath/test_helper'
require 'yajl/json_gem'
require File.dirname(__FILE__) + "/../server"

Goliath.env = :test

RSpec.configure do |c|
  c.include Goliath::TestHelper, :example_group => {
    :file_path => /spec\//
  }
end