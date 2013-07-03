class Users < Grape::API

  format :json

  helpers do
    def find_user
      User.find(params['id'])
    end
  end

  resource 'users' do

    #index
    get '/' do
      User.all
    end

    #new
    get '/new' do
      User.new
    end

    #create
    post '/' do
      userparams = JSON.parse(env.params)
      User.create!(userparams['user'])
    end

    #edit
    get '/:id/edit' do
      find_user
    end

    #show
    get '/:id' do
      find_user
    end

    #update
    put '/:id' do
      userparams = JSON.parse(env.params)
      find_user.update_attributes!(userparams['user'])
    end

    #destory
    delete '/:id' do
      find_user.destroy
    end


  end


end