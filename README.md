#Sweater Weather
## Table of Contents
- [Overview](#overview)
- [Getting Started](#getting-started)
    - [Ruby & Rails Versions](#ruby-&-rails-versions)
    - [Testing](#testing)
    - [Extras](#extras)
- [Design](#design)
    - [Schema](#schema)
    - [Endpoints](#endpoints)
- [Contributor](#contributor)

***
## Overview

***

##Getting Started

##Ruby & Rails versions
- Ruby 2.5.3
- Rails 5.2.4.3

##Local Setup Instructions
1. Fork and clone this repo into a new directory.
2. CD into `sweater_weather`
3. Run `bundle install` to install gem packages.
4. Run `rails db:setup` to setup the databases.

### Testing
- Run Unit tests: `bundle exec rspec`
- Run through the different endpoints by running your server from the console: `rails s`
    - You can then utilize Postman to delve into all of the endpoints created in this API
    [![Run in Postman](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/939ae4469e708be62766)
### Extras

**Gems**
- [`rspec-rails`](https://github.com/rspec/rspec-rails) - testing suite
- [`factory-bot`](https://github.com/thoughtbot/factory_bot) - testing object generator
- [`faker`](https://github.com/faker-ruby/faker) - generates fake data for testing
- [`pry`](https://github.com/pry/pry) - runtime developer console
- [`capybara`](https://github.com/teamcapybara/capybara) - aids in application testing and interaction
- [`simplecov`](https://github.com/simplecov-ruby/simplecov) - tracks test coverage
- [`shoulda-matchers`](https://github.com/thoughtbot/shoulda-matchers) - simplifies testing syntax
- [`launchy`](https://rubygems.org/gems/launchy/versions/2.5.0) - helper class for launching cross-platform applications
- [`rubocop-rails`](https://github.com/rubocop-hq/rubocop-rails) - enforces Rails best practices and coding conventions
- fastjson-api

***

## Design
***
### Schema

### Endpoints

***
## Contributor
- Shaunda Cunningham (she/her)
  - [GitHub: smcunning](https://github.com/smcunning)
