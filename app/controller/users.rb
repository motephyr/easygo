class Users < Grape::API

  format :json

  helpers do
    def find_user
      User.find(params[:id])
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
      User.create!(params[:user])
    end

    #edit
    params do
        requires :id, type: String
    end
    get '/:id/edit' do
      find_user
    end

    #show
    params do
        requires :id, type: String
    end
    get '/:id' do
      find_user
    end

    #update
    params do
        requires :id, type: String
        requires :user, type: String
    end
    put '/:id' do
      find_user.update_attributes!(params[:user])
    end

    #destory
    params do
        requires :id, type: String
    end
    delete '/:id' do
      find_user.destroy
    end


  end


end