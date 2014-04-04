require 'sinatra/base'

class UrlShortApp < Sinatra::Application
  URLS = []

  get '/' do
    erb :index
  end

  post '/' do
    original_url = params[:url_to_shorten]
    permalink = URLS.length+1
    redirect_url = "#{request.host}/#{permalink}"
    redirect_data = {
      :original_url => original_url,
      :permalink => permalink,
      :redirect_url => redirect_url
    }
    URLS << redirect_data
    redirect "/#{permalink}?stats=true"
  end

  get '/:id' do
    redirect_data = URLS[(params[:id].to_i)-1]
    if params[:stats]
      erb :show, locals: { :redirect_data => redirect_data }
    else
      redirect redirect_data[:original_url]
    end
  end
end