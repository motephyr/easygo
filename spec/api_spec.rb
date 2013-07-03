require 'spec_helper'
require 'rack/test'

describe Api do
  include Rack::Test::Methods

  def app
    Api
  end

  it "should be in any roles assigned to it" do
    user = Api.new
    user.assign_role("assigned role")
    user.should be_in_role("assigned role")
  end

  it "should_not be in any roles not assigned to it" do
    user = Api.new
    user.should_not be_in_role("unassigned role")
  end

  it "returns /route_info/ if /test(.:format)" do
    get "/test.json?a=1&b=2"
    last_response.body.should =~ /route_info/
  end

  def putsInfo
    puts last_response.status
    puts last_response.body
    puts last_response.header
  end





end