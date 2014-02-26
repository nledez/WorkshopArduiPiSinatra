require 'sinatra'
require "sinatra/reloader" if development?

get '/' do
  '{ "0": 12, "1": 43, "2": 42, "3": 45, "4": 23, "5": 23, "-1": 0}'
end

get '/allumer-lumiere' do
  @@lumiere = "Allume"
end

get '/eteint-lumiere' do
  @@lumiere = "Eteint"
end

get '/lumiere' do
  if defined? @@lumiere
    @@lumiere
  else
    @@lumiere = "Eteint"
  end
end
