require "sinatra"
require "sinatra/activerecord"
require "sinatra/reloader"
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

get '/' do
  client = NasaApod::Client.new(api_key: ENV['NASA_API_KEY'])
  @result = client.search(date: Time.now.strftime("20%y-%m-%d"))
  @all_posts = Post.all.reverse
  erb :index
end

get '/post' do
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
  redirect '/'
end

get '/profile' do
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
  erb :log_in
end

post "/log_in" do
  @user = User.find_by(username: params[:username])

  # checks to see if the user exists
  #   and also if the user password matches the password in the db
  if @user && @user.password == params[:password]
    # this line signs a user in
    session[:user_id] = @user.id

    redirect "/"
  else
    # if user does not exist or password does not match then
    #   redirect the user to the sign in page
    redirect "/log_in"
  end
end

get "/sign-in" do
  erb :user_page
end

get "/log_out" do
  # this is the line that signs a user out
  session[:user_id] = nil
  redirect "/"
end

get "/sign_up" do
  erb :sign_up
end

post "/sign_up" do
  @user = User.create(
    username: params[:username],
    password: params[:password],
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

  # assuming this page exists
  redirect "/"
end