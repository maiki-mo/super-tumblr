require "sinatra"
require "sinatra/activerecord"
require "sinatra/reloader"
require "./models"

set :database, "sqlite3:main.db"

enable :sessions

get '/' do
  erb :index
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
  else
    # if user does not exist or password does not match then
    #   redirect the user to the sign in page
    redirect "/log_in"
  end
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
    email: params[:email],
  )

  # this line does the signing in
  session[:user_id] = @user.id

  # assuming this page exists
  redirect "/signed_in_page"
end