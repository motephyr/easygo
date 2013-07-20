Dir["app/controller/*.rb"].each {|file| require file}
Dir["app/model/*.rb"].each {|file| require file}
require 'goliath/rack/templates'
require 'goliath/plugins/latency'

class GrapeApi < Grape::API

  rescue_from :all do |e|
    Rack::Response.new([ e.message ], 500, { "Content-type" => "application/json" }).finish
  end

  mount Users

  get '/test(.:format)' do
    params
  end

  def in_role?(role) 
    role == @role
  end

  def assign_role(role)
    @role = role
  end
end

class GoliathApi < Goliath::API
  include Goliath::Rack::Templates      # render templated files from ./views

  plugin Goliath::Plugin::Latency       # ask eventmachine reactor to track its latency

  def recent_latency
    Goliath::Plugin::Latency.recent_latency
  end

  def response(env)
    case env['PATH_INFO']
    when '/', '/erb' ,'/erb/' then [200, {}, erb(:index, :views => Goliath::Application.root_path('app/view'))]
    else                   raise Goliath::Validation::NotFoundError
    end
  end
end