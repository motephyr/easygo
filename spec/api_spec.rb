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

  it "returns 200 if /test(.:format)" do
    get "/test.json?a=1"
    last_response.status.should == 200
    last_response.body.should == '{"code":200,"a":"1"}'
  end





end