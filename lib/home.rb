require 'sinatra'
require 'json'

get '/' do
  if params[:name].nil?
    "Hello World".strip
  else
    "Hello #{params[:name]}".strip
  end
end

get '/temperature-init' do
  @@temperature = []
end

get '/temperature' do
  @@temperature.to_json
end

post '/temperature' do
  @@temperature << params[:temperature].to_i
  #puts params[:temperature].to_i
  'OK'
end
