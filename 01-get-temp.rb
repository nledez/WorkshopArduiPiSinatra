require 'sinatra'
require 'haml'
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
    # temps_json = valeursSurArduino 'http://192.168.2.177/'
    temps_json = valeursSurArduino 'http://localhost:4568/'
    #temps_json = '{ "0": 12, "1": 43, "2": 42, "3": 45, "4": 23, "5": 23, "-1": 0}'
    @@temps = JSON.parse(temps_json)
  end

  def prendreEtatLumiere
    @@lumiere = valeursSurArduino 'http://localhost:4568/lumiere'
  end

  get '/' do
    redirect to('/temperatures')
  end

  get '/temperatures' do
    prendreLaTemperature
    prendreEtatLumiere
    @temps = @@temps
    @lumiere = @@lumiere
    haml :temperatures, :format => :html5
  end

  get '/temperatures.json' do
    prendreLaTemperature
    @@temps.to_s
  end

  post '/lumiere' do
    # {"action"=>{"eteindre"=>"Eteindre"}}
    action = params["action"].first[0]
    valeursSurArduino "http://localhost:4568/#{action}-lumiere"
    redirect to('/temperatures')
  end
end
