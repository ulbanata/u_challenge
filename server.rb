require 'sinatra'
require 'active_record'
require 'pry-debugger'

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
  RequestHandler.create_profile(JSON.parse(request.body.read)).to_json(:include => :brands)
end

get '/profile/:id' do
  Profile.find(params[:id]).brands.to_json(:include => :brands)
end

put '/profile/:id' do
  RequestHandler.update_profile(JSON.parse(request.body.read), params[:id]).to_json(:include => :brands)
end

get '/brand' do
  "Brands"
end

get '/brand/:id' do
  Brand.find(params[:id]).to_json(:include => :profiles)
end
