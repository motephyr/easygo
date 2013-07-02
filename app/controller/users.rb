class Users < Grape::API

  format :json

  resource '/users' do
    get '/' do
      User.all
    end

    post '/create' do
      params = JSON.parse(env.params)
      User.create(params['user'])
    end

    get '/:id' do
      User.find(params['id'])
    end


  end
end