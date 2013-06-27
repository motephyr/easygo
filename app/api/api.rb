Dir[File.dirname(__FILE__)+"/controller/*.rb"].each {|file| require file}
Dir[File.dirname(__FILE__)+"/*.rb"].each {|file| require file}

class Api < Grape::API

  rescue_from :all do |e|
    Rack::Response.new([ e.message ], 500, { "Content-type" => "application/json" }).finish
  end

  mount Controller::Users

  #必要的參數
  #params {requires :a, :type => String}
  #for test
  get '/test(.:format)' do
    data = {:a => params[:a]}
    {:code => 200}.merge!(data)
  end
end