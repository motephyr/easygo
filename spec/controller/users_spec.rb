require 'spec_helper'
require 'rack/test'

describe Users do
  include Rack::Test::Methods

  def app
    Users
  end


  describe "GET /users" do


    it 'should be /user/ if request get "/users" ' do
      request_data = {
        :path => '/users'
      }
      with_api(Server) do
        get_request(request_data) do |c|
          resp = JSON.parse(c.response)
          resp.to_s.should =~ /user/
        end
      end
    end

    it 'should be new page if request get "/users" ' do
      request_data = {
        :path => '/users/new'
      }
      with_api(Server) do
        get_request(request_data) do |c|
          resp = JSON.parse(c.response)
          resp.to_s.should =~ /user/
        end
      end
    end

    it 'should be create if request post "/" ' do
      request_data = {
        :path => '/users',
        :body => '{"user":{"email":"David Jones","password":"this is my message"}}'
      }
      with_api(Server) do
        post_request(request_data) do |c|
          resp = JSON.parse(c.response)
          $path = '/users/'+resp['user']['id'].to_s
          puts 'test user path='+$path
          resp.to_s.should =~ /user/
        end
      end
    end

    it 'should be edit page if request get "/users" ' do
      request_data = {
        :path => $path+'/edit'
      }
      with_api(Server) do
        get_request(request_data) do |c|
          resp = JSON.parse(c.response)
          resp.to_s.should =~ /user/
        end
      end
    end

    it 'should be select if request get "/users/:id" ' do
      request_data = {
        :path => $path
      }
      with_api(Server) do
        get_request(request_data) do |c|
          resp = JSON.parse(c.response)
          resp.to_s.should =~ /user/
        end
      end
    end

    it 'should be update if request put "/users/:id" ' do
      request_data = {
        :path => $path,
        :body => '{"user":{"email":"xx","password":"xx"}}'
      }
      with_api(Server) do
        put_request(request_data) do |c|
          c.response == ''
        end
      end
    end

    it 'should be delete if request delete "/users/:id" ' do
      request_data = {
        :path => $path
      }
      with_api(Server) do
        delete_request(request_data) do |c|
          resp = JSON.parse(c.response)
          resp.to_s.should =~ /user/
        end
      end
    end
  end
end