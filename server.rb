require 'sinatra'
require 'sinatra/activerecord'

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

get '/' do
  'Hello World!'
end
