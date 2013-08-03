require 'goliath'
class Test < Goliath::API
  include Goliath::Validation

  def on_headers(env, headers)
    env.logger.info 'received headers: ' + headers.inspect
    env['async-headers'] = headers
  end
 
  def on_body(env, data)
    env.logger.info "received data #{data.size}"
    (env['async-body'] ||= '') << data
  end
 
  def on_close(env)
    env.logger.info 'closing connection'
  end
 
  def response(env)

    gh = EM::HttpRequest.new("http://localhost:9000/upload")
                  .post(:head => env['async-headers'],
                        :body => env['async-body'])
 
    gh.callback {
      logger.info "Received #{gh.response_header.status} from Upstream"
      env.stream_send gh.response
      env.stream_close
    }
 
    gh.error {
      env.stream_close
    }
 
    streaming_response(200, {'X-Stream' => 'Uploaddddd'})
  end
 
end