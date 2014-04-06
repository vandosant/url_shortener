require 'sinatra/base'
require 'uri'

class UrlShortApp < Sinatra::Application
  URLS = []
  set :invalid_url, false

  get '/' do
    erb :index, locals: {:error_status => settings.invalid_url}
  end

  post '/' do
    form_input = params[:url_to_shorten]

    unless form_input != "" && form_input.include?(".")
      settings.invalid_url = true
      redirect '/'
    end

    unless form_input.include?("http://")
      form_input = "http://#{form_input}"
    end

    unless form_input.match(URI.regexp)
      settings.invalid_url = true
      redirect '/'
    end

    original_url = form_input
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
      redirect redirect_data[:original_url]
    end
  end
end