require "sinatra"
require "sinatra/activerecord"
require "sinatra/reloader"

set :database, "sqlite3:main.db"