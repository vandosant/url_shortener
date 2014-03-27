require 'sinatra/base'

class UrlShortApp < Sinatra::Application
  get '/' do
    erb :index
  end
end