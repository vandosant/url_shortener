require 'spec_helper'
require 'capybara/rspec'
require_relative ('../url_short_app')
Capybara.app = UrlShortApp

feature "User can shorten a URL" do
  let(:db) { DB }

  before do
    db.create_table! :url_table do
      primary_key :permalink
      String :original_url
      String :redirect_url
      Integer :visits, default: 0
    end
  end

  scenario "User can visit homepage and sees a form" do
    visit '/'
    expect(page).to have_button("Shorten")
  end

  scenario "User completes form and gets a shortened URL" do
    visit '/'

    fill_in "url_to_shorten", with: "www.google.com"
    click_on "Shorten"

    expect(page).to have_content("Original URL")
    expect(page).to have_content("www.google.com")
    expect(page).to have_content('"Shortened" URL')
    expect(page).to have_content(current_path)
    expect(page).to have_content("'Shorten' another URL")
  end

  scenario "User visits short url and is redirected to original" do
    visit '/'

    fill_in "url_to_shorten", with: "www.google.com"
    click_on "Shorten"
    visit current_path

    expect(current_host).to eq "http://www.google.com"

  end

  scenario "User gets an error message if they submit a blank form" do
    visit '/'

    fill_in "url_to_shorten", with: ""
    click_on "Shorten"

    expect(page).to have_content("The text you entered is not a valid URL")
  end

  scenario "User gets an error message if they submit an invalid url" do
    visit '/'

    fill_in "url_to_shorten", with: "halfuahwafv;alsa"
    click_on "Shorten"

    expect(page).to have_content("The text you entered is not a valid URL")
  end

  scenario "User sees the number of visits for a URL" do
    visit '/'

    fill_in "url_to_shorten", with: "www.github.com"
    click_on "Shorten"

    stats_path = current_url
    redirect_path = current_url.gsub(/[?].+/, '')

    5.times { visit redirect_path}

    visit stats_path

    expect(page).to have_content("Total visits")
    expect(page).to have_content("5")
  end
end