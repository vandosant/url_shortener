require 'sequel'
DB = Sequel.connect(ENV['DATABASE_URL'] || 'postgres://gschool_user:password@localhost:5432/url_repository_development')

require './url_short_app'
run UrlShortApp

