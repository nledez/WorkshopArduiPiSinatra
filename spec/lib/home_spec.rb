ENV['RACK_ENV'] = 'test'

require 'home'
require 'rspec'
require 'rack/test'

describe 'The Home App' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it "says hello" do
    get '/'
    expect(last_response).to be_ok
    expect(last_response.body).to eq('Hello World')
  end

  it "says hello name if I give a name" do
    get '/?name=toto'
    expect(last_response).to be_ok
    expect(last_response.body).to eq('Hello toto')
  end

  it "save temperature" do
    get '/temperature'
    expect(last_response).to be_ok
    expect(last_response.body).to eq('[]')

    post '/temperature', params={:temperature => 18}
    expect(last_response).to be_ok
    expect(last_response.body).to eq('18')
  end
end
