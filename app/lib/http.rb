require 'goliath'
require 'em-synchrony/em-http'

module Tool
  class Http
    def request(url)
      http = EM::HttpRequest.new(url).get 
      http.response
    end
  end
end