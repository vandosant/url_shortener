URL Shortener
================

This app will allow a user to shorten a desired URL.

* Homepage has a form for user to fill out: Original URL, Shortened URL, "shorten" button
* Once shortened, user is redirected to Original URL
* Visits to a shortened URL are calculated and displayed on the stats page
* User has the option of choosing a vanity URL
* Error messages are received when:
  * User inputs a invalid or blank URL
  * User inputs an already existing vanity URL
  * User inputs a vanity URL that contains profanity
  * User inputs a vanity URL that is too long (more than 12 characters)
  * User inputs a vanity URL containing non-letters

=======================
DEVELOPMENT
=======================
1. `bundle install`
1. Create a database by running `psql -d postgres -f scripts/create_database.sql`
1. Run the migrations in the development database using `sequel -m migrations postgres://gschool_user:password@localhost/url_repository_development`
1. Run the migrations in the test database using `sequel -m migrations postgres://gschool_user:password@localhost/url_repository_test`
1. `rerun rackup`
    * running rerun will reload app when file changes are detected
1. Run tests using `rspec spec`.

=======================
MIGRATIONS ON HEROKU
=======================
To run the migrations on heroku, run `heroku run 'sequel -m migrations $HEROKU_POSTGRESQL_BROWN_URL' --app rrp-staging`
or `heroku run 'sequel -m migrations HEROKU_POSTGRESQL_IVORY_URL' --app rrp`


=======================
LINKS
=======================
GitHub Repo - https://github.com/vandosant/url_shortener
Staging Site - http://rrp-staging.herokuapp.com
Production Site - http://rrp.herokuapp.com