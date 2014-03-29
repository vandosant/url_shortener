require 'sinatra/base'

class UrlShortApp < Sinatra::Application
  URLS = []

  get '/' do
    erb :index
  end

  post '/:id' do
    original_url = params[:url_to_shorten]
    URLS << { original_url => "tny.herokuapp.com/#{params[:id]}" }
    erb :show, locals: { :url_index => params[:id].to_i-1, :original_url => original_url }
  end
end