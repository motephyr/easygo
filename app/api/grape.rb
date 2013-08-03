Dir["app/controller/*.rb"].each {|file| require file}
Dir["app/model/*.rb"].each {|file| require file}

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