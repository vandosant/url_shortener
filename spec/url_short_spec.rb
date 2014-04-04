require 'spec_helper'
require 'capybara/rspec'
require_relative ('../url_short_app')
Capybara.app = UrlShortApp

feature "User can shorten a URL" do
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
    expect(page).to have_content("/1")
    expect(page).to have_content("'Shorten' another URL")
  end
end