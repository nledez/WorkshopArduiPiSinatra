require 'sinatra'
require 'erb'
require 'json'
require 'net/http'

class MoniteurTemperature < Sinatra::Base
  def valeursSurArduino(uri)
    url = URI.parse(uri)
    req = Net::HTTP::Get.new(url.path)
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }
    res.body
  end

  def prendreLaTemperature
    #temps_json = valeursSurArduino 'http://192.168.2.177/'
    temps_json = '{ "0": 12, "1": 43, "2": 42, "3": 45, "4": 23, "5": 23, "-1": 0}'
    @@temps = JSON.parse(temps_json)
  end

  get '/temperatures' do
    prendreLaTemperature
    @temps = @@temps
    erb :temperatures
  end

  get '/temperatures.json' do
    prendreLaTemperature
    @@temps.to_s
  end
end
