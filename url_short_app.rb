require 'sinatra/base'
require 'uri'
require_relative 'lib/url_repository'

class UrlShortApp < Sinatra::Application
  set :invalid_url, false
  set :url_repo, UrlRepository.new(DB)

  get '/' do
    erb :index, locals: {:error_status => settings.invalid_url}
  end

  post '/' do
    form_input = params[:url_to_shorten]

    unless form_input != "" && form_input.match(/[a-zA-Z]*[.][a-zA-Z]{2,4}/)
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
    permalink = settings.url_repo.add(original_url, request.base_url)
    settings.invalid_url = false
    redirect "/#{permalink}?stats=true"
  end

  get '/:id' do
    redirect_data = settings.url_repo.find(params[:id])
    if params[:stats]
      erb :show, locals: {:redirect_data => redirect_data}
    else
      settings.url_repo.count_visit(redirect_data)
      redirect redirect_data[:original_url]
    end
  end
end