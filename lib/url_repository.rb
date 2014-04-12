require 'sequel'

class UrlRepository
  def initialize(db)
    @table = db[:url_table]
  end

  def add(original_url, host, random_number=nil)
    this_permalink = @table.insert(:original_url => original_url)
    if random_number == nil
      random_number = this_permalink
    end
    redirect_url = "#{host}/#{random_number}"
    @table.where(:permalink => this_permalink).update(:redirect_url => redirect_url)

    this_permalink
  end

  def all
    @table.to_a.first
  end

  def find(permalink)
    @table.where(:permalink => permalink).to_a.first
  end

  def find_by_path(host, number)
    @table.where(:redirect_url => "#{host}/#{number}").to_a.first
  end

  def count_visit(row)
    new_visits = row[:visits] + 1
    @table.where(:permalink => row[:permalink]).update(:visits => new_visits)
  end
end