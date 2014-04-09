require 'sinatra'

get '/' do
  if params[:name].nil?
    "Hello World".strip
  else
    "Hello #{params[:name]}".strip
  end
end

get '/temperature' do
  '[]'
end

post '/temperature' do
  '18'
end
