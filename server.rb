require 'bundler/setup'
Bundler.require

require 'goliath/websocket'
$:.unshift File.expand_path('..', __FILE__)
require 'app/api'

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

  def on_body(env, data)
    if env.respond_to?(:handler)
      super env, data
    else
      env['params'] = data
    end
  end

  def response(env)
    case env['REQUEST_PATH']
    when '/chat'
      super(env)
    when '/app.js'
      [200, {'Content-Type' => 'application/javascript'}, coffee(:app)]
    when '/'
      [200, {}, haml(:index)]
    else
      Api.call(env) 
    end
  end


end




#binding.pry