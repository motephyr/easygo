module Controller
  class Users < Grape::API

    

    resource '/users' do
      get '/' do
        'all'
        #User.all
      end

      get '/create' do
        User.create(params['user'])
      end

      get '/add' do
        'add'
      end

      get '/:id' do
        User.find(params['id'])
      end


    end
  end
end