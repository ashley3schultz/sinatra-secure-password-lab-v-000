require "./config/environment"
require "./app/models/user"
class ApplicationController < Sinatra::Base

  configure do
    set :views, "app/views"
    enable :sessions
    set :session_secret, "password_security"
  end

  get "/" do
    erb :index
  end

  get "/signup" do
    erb :signup
  end

  post "/signup" do
    binding.pry
    if params[:username] == "" || params[:username] == nil
      erb :failure
    elsif params[:password] == "" || params[:password] == nil
      erb :failure
    else 
      erb :login
    #if params[:username].empty? && params[:passwaord]
    #  user = User.new(username: params[:username], password: params[:password], balance: 0)
    #  user.save
    #  redirect '/login'
    #else
    #  erb :failure
    #end
  end

  get '/account' do
    if logged_in?
      @user = current_user
      erb :account
    else
      redirect '/login'
    end
  end


  get "/login" do
    erb :login
  end

  post "/login" do
    binding.pry
    #user = User.find_by(:username => params[:username])
		#if user && user.authenticate(params[:password])
		#	session[:user_id] = user.id
    #  redirect "/account"
    #else
    #  redirect "/failure"
    #end
	end

  get "/failure" do
    erb :failure
  end

  get "/logout" do
    session.clear
    redirect "/"
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end

end
