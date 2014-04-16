require 'sinatra'
require 'json'
require 'mongo'
require 'json/ext'

class TemperatureServer < Sinatra::Base
  include Mongo

  configure do
    conn = MongoClient.new("localhost", 27017)
    set :mongo_db, conn.db('test')
  end

  get '/temperature' do
    content_type :json
    result = settings.mongo_db['temperature'].find.to_a
    result.map{ |e| e.delete_if { |k, v| k == "_id" } }.to_json
  end

  post '/temperature' do
    content_type :json
    new_id = settings.mongo_db['temperature'].insert params
    document_by_id(new_id)
    'OK'
  end

  helpers do
  # a helper method to turn a string ID
  # representation into a BSON::ObjectId
  #def object_id val
  #  BSON::ObjectId.from_string(val)
  #end

  def document_by_id id
    id = object_id(id) if String === id
    settings.mongo_db['temperature'].find_one(:_id => id).to_json
  end
end
end
