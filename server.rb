require 'sinatra'
require 'active_record'

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

end

post '/profile' do
  Profile.create_profile.to_json
end

get '/profile/:id' do
  Profile.find(params[:id]).brands.to_json
end

put '/profile/:id' do

end

get '/brand' do

end

get '/brand/:id' do
  Brand.find(params[:id]).profiles.to_json
end
