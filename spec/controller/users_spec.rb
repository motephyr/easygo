require File.dirname(__FILE__) + "/../spec_helper"
require 'rack/test'

describe Controller::Users do
   include Rack::Test::Methods
 
  def app
    Controller::Users
  end


  describe "GET /users" do
    it "returns add if /" do
      get "/users/add"
      putsInfo
      last_response.status.should == 200
      last_response.body.should == 'add'
    end
  

    it 'should be /Ruby Web Frameworks/ if request "/users" ' do
      get "/users/"
      putsInfo
        last_response.status.should == 200
        last_response.body.should == 'all'
        # resp = JSON.parse(c.response)
        # users = resp.map{|r|r['name']}
        # users.to_s.should =~ /Ruby Web Frameworks/
    end
  end

  def putsInfo
      puts last_response.status
      puts last_response.body
      puts last_response.header
  end



end