require 'sinatra'
require 'json'

get '/temperatures' do
  temps_json = '{"0":1023,"1":1023,"2":737,"3":550,"4":409,"5":333,"-1":0}'
  temps = JSON.parse(temps_json)
  temps.to_s
end
