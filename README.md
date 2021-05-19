# Postcode checker

A small rails app which uses the postcode.io API.

## Installing

This is a standard rails (version v6.1.3.2) set-up in "minimal" mode, so it has some dependencies but you may already have them installed. On an ubuntu virtual machine the following packages were installed:

`autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libsqlite3-dev`

Install ruby v2.7.3

Run `gem install bundler` and `bundle` to install the required gems.

## Config

Two config files are checked into the repo with data ready to go:

* `config/servable_lsoa_prefixes.txt.txt` - for defining the service area. This is a list LSOA regions (prefix LSOA strings) in which all postcodes are servable.
* `config/postcode_allowed_list.txt` - for listing any post codes we wish to return as within our service area, even if postcodes.io doesn't find them.

## Running

`bundle exec rails server` to run the server and then....

Browse to http://localhost:3000 to see the postcode checker.

## Tests

`bundle exec rspec` to run the tests.

`bundle exec rubocop` for code style/lint checks.
