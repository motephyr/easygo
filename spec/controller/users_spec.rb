require 'spec_helper'
require 'rack/test'

describe Users do
  include Rack::Test::Methods

  def app
    Users
  end


  describe "GET /users" do

    it 'should be /created_at/ if request "/users" ' do
      with_api(Server) do
        get_request(:path => '/users') do |c|
          resp = JSON.parse(c.response)
          users = resp.map{|r|r['user']}
          users.to_s.should =~ /created_at/
        end
      end
    end

    it 'should be /created_at/ if request "/users/1" ' do
      with_api(Server) do
        get_request(:path => '/users/1') do |c|
          resp = JSON.parse(c.response)
          resp.to_s.should =~ /created_at/
        end
      end
    end


  end





end