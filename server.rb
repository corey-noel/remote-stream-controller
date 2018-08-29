require 'sinatra'

get '/' do
  erb :test
end

post '/update' do
  puts request.body.read
end

