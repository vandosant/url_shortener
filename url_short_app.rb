require 'sinatra/base'

class UrlShortApp < Sinatra::Application
  URLS = []

  get '/' do
    erb :index
  end

  post '/' do
    original_url = params[:url_to_shorten]
    URLS << { original_url => "tny.herokuapp.com/#{URLS.length+1}" }
    this_path = "/#{URLS.length.to_s}"
    redirect this_path
  end

  get '/:id' do
    erb :show, locals: { :url_index => params[:id].to_i-1, :original_url => URLS[(params[:id].to_i)-1].keys[0] }
  end
end