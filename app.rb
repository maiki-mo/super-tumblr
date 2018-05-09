require "sinatra"
require "sinatra/activerecord"
require "sinatra/reloader"
require "sinatra/flash"
require "./models"
require 'nasa_apod'

configure :development do
  set :database, "sqlite3:main.db"
  require 'pry'
end

configure :production do
  set :database, ENV["DATABASE_URL"]
end

enable :sessions
set :sessions, :expire_after => (60 * 4)


get '/' do
  if session[:user_id] != nil
    @user = User.find(session[:user_id])
  end
  client = NasaApod::Client.new(api_key: ENV['NASA_API_KEY'])
  @result = client.search(date: Time.now.strftime("20%y-%m-%d"))
  @all_posts = Post.all.reverse
  erb :index
end

put '/' do
  param = params[:dom_state]
  user = User.find(session[:user_id])
  if param != user.dom_state
    flash[:info] = "Theme Changed"
  end
  user.update(dom_state: param)
  redirect '/#title'
end

get '/post' do
  if session[:user_id] != nil
    @user = User.find(session[:user_id])
  end
  erb :post
end

post '/post' do
  Post.create(
    title: params[:title],
    subject: params[:subject],
    content: params[:content],
    user_id: session[:user_id],
    profile_id: session[:user_id]
  )
  flash[:info] = "Post Added"
  redirect '/'
end

get '/profile' do
  if session[:user_id] != nil
    @user = User.find(session[:user_id])
  end
  id = session[:user_id]
  @user_posts = User.find(id).posts.reverse
  erb :profile
end

post '/profile' do
  title = params[:title]
  id = session[:user_id]
  user = User.find(id)
  if title != user.username
    redirect '/profile'
  else
    user.posts.destroy
    user.profile.destroy
    user.destroy
    session[:user_id] = nil
    redirect '/'
  end
end


get '/log_in' do
  if session[:user_id] != nil
    @user = User.find(session[:user_id])
  end
  erb :log_in
end

post "/log_in" do
  @user = User.find_by(username: params[:username])

  if @user && @user.password == params[:password]
    session[:user_id] = @user.id

    flash[:info] = "You are now signed in"

    redirect "/"
  else
    
    flash[:info] = "Your password or username is incorrect"
    
    redirect "/log_in"
  end
end

get "/log_out" do
  if session[:user_id] != nil
    @user = User.find(session[:user_id])
  end
  session[:user_id] = nil
  redirect "/"
end

get "/sign_up" do
  if session[:user_id] != nil
    @user = User.find(session[:user_id])
  end
  erb :sign_up
end

post "/sign_up" do
  @user = User.create(
    username: params[:username],
    password: params[:password],
    dom_state: "night"
  )
  Profile.create(
    first_name: params[:first_name],
    last_name: params[:last_name],
    birthday: params[:birthday],
    email: params[:email],
    user_id: @user.id
  )

  # this line does the signing in
  session[:user_id] = @user.id

  flash[:info] = "Your account is now active"

  # assuming this page exists
  redirect "/"
end