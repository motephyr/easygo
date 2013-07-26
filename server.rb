require 'bundler/setup'
Bundler.require

require 'pry'
require 'goliath/websocket'
$:.unshift File.expand_path('..', __FILE__)
require 'app/api'
require 'app/lib/http'
require 'app/lib/jms/subscribe'
require 'java'

class Server < Goliath::WebSocket
  # render templated files from ./views
  include Goliath::Rack::Templates
  # render static files from ./public
  use(Rack::Static,                     
    :root => Goliath::Application.app_path("public"),
    :urls => ["/bootstrap","/favicon.ico",'/html', '/css', '/js', '/images'])
  use Goliath::Rack::Params

  Thread.new do
    MQ.new.startServer 
  end
  
  def on_open(env)
    env.logger.info("CHAT OPEN")
    env['subscription'] = env.channel.subscribe { |m| env.stream_send(m) }
  end

  def on_message(env, msg)
    env.logger.info("CHAT MESSAGE: #{msg}")
    env.channel << msg
  end

  def on_close(env)
    env.logger.info("CHAT CLOSED")
    env.channel.unsubscribe(env['subscription'])
  end

  def on_error(env, error)
    env.logger.error error
  end

  def on_body(env, data)
    if env.respond_to?(:handler)
      return super env, data
    end
    env["rack.input"] = StringIO.new data
  end

  def response(env)
    case env['REQUEST_PATH']
    when '/request'
      [200, {},Tool::Http.new.request(params['url'])]
    when '/chat'
      super(env)
    when '/', /erb/
      GoliathApi.new.call(env) 
    else
      GrapeApi.call(env) 
    end
  end


end


