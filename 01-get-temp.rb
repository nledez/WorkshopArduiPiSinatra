require 'sinatra'
require 'json'
require 'net/http'

get '/temperatures' do
  url = URI.parse('http://192.168.2.177/')
  req = Net::HTTP::Get.new(url.path)
  res = Net::HTTP.start(url.host, url.port) {|http|
    http.request(req)
  }
  temps_json = res.body
  temps = JSON.parse(temps_json)
  temps.to_s
end
