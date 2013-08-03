require 'goliath/rack/templates'
require 'goliath/plugins/latency'
$:.unshift File.expand_path('..', __FILE__)
require 'app/lib/http'

class GoliathApi < Goliath::API
  include Goliath::Rack::Templates      # render templated files from ./views

  plugin Goliath::Plugin::Latency       # ask eventmachine reactor to track its latency

  def recent_latency
    Goliath::Plugin::Latency.recent_latency
  end

  def response(env)
    case env['PATH_INFO']
    when '/', '/erb' ,'/erb/' then [200, {}, erb(:index, :views => Goliath::Application.root_path('app/view'))]
    when '/request'
      [200, {},Tool::Http.new.request(params['url'])]
    else                   raise Goliath::Validation::NotFoundError
    end
  end
end