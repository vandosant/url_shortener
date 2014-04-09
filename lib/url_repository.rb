require 'sequel'

class UrlRepository
  def initialize(db)
    @table = db[:url_table]
  end

  def add(original_url, host)
    this_permalink = @table.insert(:original_url => original_url)
    redirect_url = "#{host}/#{this_permalink}"
    @table.where(:permalink => this_permalink).update(:redirect_url => redirect_url)

    this_permalink
  end

  def all
    @table.to_a.first
  end

  def find(permalink)
    @table.where(:permalink => permalink).to_a.first
  end

  def count_visit(row)
    new_visits = row[:visits] + 1
    @table.where(:permalink => row[:permalink]).update(:visits => new_visits)
  end
end