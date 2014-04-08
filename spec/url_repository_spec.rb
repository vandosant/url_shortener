require 'spec_helper'
require_relative '../lib/url_repository'

describe UrlRepository do
  let (:db) {Sequel.connect('postgres://gschool_user:password@localhost:5432/url_repository_test')}

  before do
    db.create_table :url_table do
      primary_key :permalink
      String :original_url
      String :redirect_url
    end
  end

  after do
    db.drop_table :url_table
  end
  it "is able to hold redirect data" do
    repo = UrlRepository.new(db)

    repo.add("http://www.google.com", "http://localhost:9292")
    actual = repo.all

    expected = {
      :permalink => 1,
      :original_url => "http://www.google.com",
      :redirect_url => "http://localhost:9292/1"
    }

    expect(actual).to eq expected
  end

  it "is able to find a url by permalink" do
    repo = UrlRepository.new(db)

    repo.add("http://www.google.com", "http://localhost:9292")
    actual = repo.find(1)

    expected = {
      :permalink => 1,
      :original_url => "http://www.google.com",
      :redirect_url => "http://localhost:9292/1"
    }

    expect(actual).to eq expected
  end
end