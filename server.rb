require 'sinatra'
require 'sinatra/flash'
require 'json'

enable :sessions

output_file = "streamcontrol.json"

get '/control' do
  erb :index
end

post '/update' do
  vals = JSON.parse(request.body.read)
  vals[:timestamp] = Time.new.to_i
  File.open(output_file, "w") do |f|
    f.write(vals.to_json)
  end
  200
end

