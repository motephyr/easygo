require 'spec_helper'
require 'rack/test'

describe GrapeApi do
  include Rack::Test::Methods

  def app
    GrapeApi
  end

  it "should be in any roles assigned to it" do
    user = GrapeApi.new
    user.assign_role("assigned role")
    user.should be_in_role("assigned role")
  end

  it "should_not be in any roles not assigned to it" do
    user = GrapeApi.new
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

describe GoliathApi do

  it 'renders erb template from string with default erb layout' do
    with_api(GoliathApi) do
      get_request(:path => '/erb') do |c|
        c.response.should =~ %r{<!DOCTYPE html>}
      end
    end
  end

end