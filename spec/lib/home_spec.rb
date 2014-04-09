require File.dirname(__FILE__) + '../../spec_helper'
ENV['RACK_ENV'] = 'test'

require 'home'
require 'rspec'
require 'rack/test'

describe 'The Home App' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it "save temperature" do
    get '/temperature-init'
    get '/temperature'
    expect(last_response).to be_ok
    expect(last_response.body).to eq('[]')

    post '/temperature', params={:temperature => 18}
    expect(last_response).to be_ok
    expect(last_response.body).to eq('OK')

    get '/temperature'
    expect(last_response).to be_ok
    expect(last_response.body).to eq('[18]')

    post '/temperature', params={:temperature => 19}

    get '/temperature'
    expect(last_response.body).to eq('[18,19]')

  end
end
