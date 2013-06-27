module Controller
  class Users < Grape::API

    format :json

    resource '/users' do
      get "/" do
        puts 'a'
      end

      get "/create" do
        puts 'c'
      end

      get "/:id" do
        puts 'b'
      end
    end
  end
end