require 'bundler/setup'
Bundler.require

require 'goliath/websocket'
require File.dirname(__FILE__) + "/app/api/api"
#require File.dirname(__FILE__) + '/config/application'

class Server < Goliath::WebSocket
  # render templated files from ./views
  include Goliath::Rack::Templates
  # render static files from ./public
  use(Rack::Static,                     
    :root => Goliath::Application.app_path("public"),
    :urls => ["/favicon.ico",'/html', '/css', '/js', '/images'])

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

  def response(env)
    if env['REQUEST_PATH'] == '/chat'
      super(env)
    elsif env['REQUEST_PATH'] == '/app.js'
      [200, {'Content-Type' => 'application/javascript'}, coffee(:app)]
    elsif env['REQUEST_PATH'] == '/'
      [200, {}, haml(:index)]
    else
      Api.call(env) 
    end
  end
end

#binding.pry