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
  @all = Post.all
  # client = NasaApod::Client.new(api_key: ENV['NASA_API_KEY'])
  # @result = client.search(date: Time.now.strftime("20%y-%m-%d"))
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
    user_id: session[:user_id]
  )
  redirect '/'
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

    redirect "/sign-in"
  else
    # if user does not exist or password does not match then
    #   redirect the user to the sign in page
    redirect "/"
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
    first_name: params[:first_name],
    last_name: params[:last_name],
    birthday: params[:birthday],
    email: params[:email]
  )

  # this line does the signing in
  session[:user_id] = @user.id

  # assuming this page exists
  redirect "/"
end