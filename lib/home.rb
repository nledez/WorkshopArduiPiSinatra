require 'sinatra'

get '/' do
  if params[:name].nil?
    "Hello World".strip
  else
    "Hello #{params[:name]}".strip
  end
end