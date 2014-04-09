require 'sinatra'
require 'json'


end

class TemperatureServer < Sinatra::Base
  get '/temperature-init' do
    @@temperature = []
  end

  get '/temperature' do
    @@temperature.to_json
  end

  post '/temperature' do
    @@temperature << params[:temperature].to_i
    'OK'
  end
end
