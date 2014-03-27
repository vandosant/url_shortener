require 'spec_helper'
require 'capybara/rspec'
require_relative ('../url_short_app')
Capybara.app = UrlShortApp

feature "User can shorten a URL" do
  scenario "User can visit homepage and sees a form" do
    visit '/'
    expect(page).to have_button("Shorten")
  end
end