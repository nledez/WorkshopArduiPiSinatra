require File.dirname(__FILE__) + '../../spec_helper'
ENV['RACK_ENV'] = 'test'

require 'home'
require 'rspec'
require 'rack/test'
require 'mongo'
require 'json/ext'

include Mongo

describe 'Temperature App' do
  include Rack::Test::Methods

  before(:each) do
    conn = MongoClient.new("localhost", 27017)
    db = conn.db('test')['temperature']
    db.find.each do |e|
      db.remove(e)
    end
  end

  def app
    @app || TemperatureServer
  end

  it "save temperature" do
    get '/temperature'
    expect(last_response).to be_ok
    expect(last_response.body).to eq('[]')

    post '/temperature', params={:temperature => 18}
    expect(last_response).to be_ok
    expect(last_response.body).to eq('OK')

    get '/temperature'
    expect(last_response).to be_ok
    expect(JSON.parse(last_response.body)).to eq([
      {"temperature" => "18"}
    ])

    post '/temperature', params={:temperature => 19}

    get '/temperature'
    expect(JSON.parse(last_response.body)).to eq([
      {"temperature" => "18"},
      {"temperature" => "19"}
    ])

    post '/temperature', params={:temperature => 15, :humidity => 40}

    get '/temperature'
    expect(JSON.parse(last_response.body)).to eq([
      {"temperature" => "18"},
      {"temperature" => "19"},
      {"temperature" => "15", "humidity" => "40"}
    ])
  end
end
