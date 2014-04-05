require 'sinatra/base'

class UrlShortApp < Sinatra::Application
  URLS = []
  set :invalid_url, false

  get '/' do
    erb :index, locals: {:error_status => settings.invalid_url}
  end

  post '/' do
    if params[:url_to_shorten] == ""
      settings.invalid_url = true
      redirect '/'
    end
    original_url = params[:url_to_shorten]
    permalink = URLS.length+1
    redirect_url = "http://#{request.host}/#{permalink}"
    redirect_data = {
      :original_url => original_url,
      :permalink => permalink,
      :redirect_url => redirect_url
    }
    URLS << redirect_data
    settings.invalid_url = false
    redirect "/#{permalink}?stats=true"
  end

  get '/:id' do
    redirect_data = URLS[(params[:id].to_i)-1]
    if params[:stats]
      erb :show, locals: {:redirect_data => redirect_data}
    else
      redirect "http://#{redirect_data[:original_url]}"
    end
  end
end