Dir["app/controller/*.rb"].each {|file| require file}
Dir["app/model/*.rb"].each {|file| require file}

class Api < Grape::API

  rescue_from :all do |e|
    Rack::Response.new([ e.message ], 500, { "Content-type" => "application/json" }).finish
  end

  mount Users

  get '/test(.:format)' do
    #必要的參數
    #params {requires :a, :type => String}
    #for test
    data = {:a => params[:a]}
    {:code => 200}.merge!(data)
  end

  def in_role?(role) 
    role == @role
  end

  def assign_role(role)
    @role = role
  end
end