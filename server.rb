require 'sinatra'
require 'active_record'
require 'pry-debugger'
require 'dalli'

# DB Config
db = URI.parse('postgres://localhost/umbelapp')

ActiveRecord::Base.establish_connection(
  :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
  :host     => db.host,
  :username => db.user,
  :password => db.password,
  :database => db.path[1..-1],
  :encoding => 'utf8'
)

require './lib/app.rb'

set :bind, '0.0.0.0'

get '/' do
  'Hello World!'
end

get '/profile' do
  "Profiles"
end

post '/profile' do
  RequestHandler.create_profile(JSON.parse(request.body.read))
end

get '/profile/:id' do
  RequestHandler.grab_profile(params[:id])
end

put '/profile/:id' do
  RequestHandler.update_profile(JSON.parse(request.body.read), params[:id])
end

get '/brand' do
  "Brands"
end

get '/brand/:id' do
  RequestHandler.grab_brand(params[:id])
end
