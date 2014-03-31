require 'spec_helper'
require 'capybara/rspec'
require_relative ('../url_short_app')
Capybara.app = UrlShortApp

feature "User can shorten a URL" do
  scenario "User able to use the URL they input" do
    visit '/'

    fill_in "url_to_shorten", with: "www.google.com"
    click_on "Shorten"

    click_link("tny.herokuapp.com/1")
  end
end