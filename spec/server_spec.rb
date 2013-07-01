require File.dirname(__FILE__) + "/spec_helper"

describe Server do

  it 'should_not be /File not found/ if request static file ' do
    with_api(Server) do
      get_request(:path => '/js/NodeChatServer.js') do |c|
        c.response.should_not =~ /File not found/
      end
    end
  end
  
end