require File.dirname(__FILE__) + "/spec_helper"

describe Server do

  it 'should_not be /File not found/ if request static file ' do
    with_api(Server) do
      get_request(:path => '/js/NodeChatServer.js') do |c|
        c.response.should_not =~ /File not found/
      end
    end
  end

  it 'should be /Ruby Web Frameworks/ if request "/users" ' do
    with_api(Server) do
      get_request(:path => '/users') do |c|
        c.response.should == "all"
        # resp = JSON.parse(c.response)
        # users = resp.map{|r|r['name']}
        # users.to_s.should =~ /Ruby Web Frameworks/
      end
    end
  end

  it 'should be "add" if request "/users/add" ' do
    with_api(Server) do
      get_request(:path => '/users/add') do |c|
        c.response.should == "add"
      end
    end
  end

  
end