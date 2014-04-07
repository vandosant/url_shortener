require 'sequel'
require 'sinatra/base'

class UrlRepository
  def initialize(db)
    @db = db
    @table = @db[:url_table]
  end

  def add(original_url, host)
    @table.insert(:original_url => original_url)
    redirect_url = "http://#{host}/#{@table.where(:original_url => original_url).to_a.first.values[0]}"
    @table.where(:original_url => original_url).update(:redirect_url => redirect_url)
  end

  def all
    @table.to_a.first
  end
end