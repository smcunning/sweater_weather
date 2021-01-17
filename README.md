# Sweater Weather
![sweater-weather-gif](https://media.giphy.com/media/26u6dryuZH98z5KuY/giphy.gif)

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
- [Acknowledgements](#Acknowledgements)

***
## Overview

***

## Getting Started

## Ruby & Rails versions
- Ruby 2.5.3
- Rails 5.2.4.3

## Local Setup Instructions
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
**Forecast by Location**
`GET /api/v1/forecast?location=city,state`

This endpoint retrieves weather forecast information based on a city/state combination. It references the MapQuest Geocoding API to find longitude and latitude coordinates which is passed to the OpenWeather One Call API to return a set of current, daily and hourly forecast information. The response is in JSON format.

Response Example:

```
{
    "data": {
        "id": "null",
        "type": "forecast",
        "attributes": {
            "current_weather": {
                "datetime": "2021-01-17T16:38:59-07:00",
                "sunrise": "2021-01-17T07:18:07-07:00",
                "sunset": "2021-01-17T17:01:48-07:00",
                "temperature": 47.61,
                "feels_like": 36.88,
                "humidity": 25,
                "uvi": 0,
                "visibility": 10000,
                "conditions": "broken clouds",
                "icon": "04d"
            },
            "daily_weather": [
                {
                    "date": "2021-01-17",
                    "sunrise": "2021-01-17T07:18:07-07:00",
                    "sunset": "2021-01-17T17:01:48-07:00",
                    "max_temp": 47.61,
                    "min_temp": 31.01,
                    "conditions": "overcast clouds",
                    "icon": "04d"
                },
                {
                    "date": "2021-01-18",
                    "sunrise": "2021-01-18T07:17:38-07:00",
                    "sunset": "2021-01-18T17:02:55-07:00",
                    "max_temp": 41.85,
                    "min_temp": 29.14,
                    "conditions": "clear sky",
                    "icon": "01d"
                },
                {
                    "date": "2021-01-19",
                    "sunrise": "2021-01-19T07:17:07-07:00",
                    "sunset": "2021-01-19T17:04:03-07:00",
                    "max_temp": 35.1,
                    "min_temp": 27.79,
                    "conditions": "scattered clouds",
                    "icon": "03d"
                },
                {
                    "date": "2021-01-20",
                    "sunrise": "2021-01-20T07:16:35-07:00",
                    "sunset": "2021-01-20T17:05:12-07:00",
                    "max_temp": 51.66,
                    "min_temp": 32.04,
                    "conditions": "clear sky",
                    "icon": "01d"
                },
                {
                    "date": "2021-01-21",
                    "sunrise": "2021-01-21T07:16:00-07:00",
                    "sunset": "2021-01-21T17:06:21-07:00",
                    "max_temp": 48.07,
                    "min_temp": 34.93,
                    "conditions": "clear sky",
                    "icon": "01d"
                }
            ],
            "hourly_weather": [
                {
                    "time": "16:00",
                    "temperature": 47.61,
                    "wind_speed": "4.12 mph",
                    "wind_direction": "↖ NW",
                    "conditions": "broken clouds",
                    "icon": "04d"
                },
                {
                    "time": "17:00",
                    "temperature": 45.37,
                    "wind_speed": "3.85 mph",
                    "wind_direction": "↑ N",
                    "conditions": "broken clouds",
                    "icon": "04d"
                },
                {
                    "time": "18:00",
                    "temperature": 43.39,
                    "wind_speed": "2.68 mph",
                    "wind_direction": "↗ NE",
                    "conditions": "overcast clouds",
                    "icon": "04n"
                },
                {
                    "time": "19:00",
                    "temperature": 41.76,
                    "wind_speed": "1.57 mph",
                    "wind_direction": "↓ S",
                    "conditions": "overcast clouds",
                    "icon": "04n"
                },
                {
                    "time": "20:00",
                    "temperature": 40.59,
                    "wind_speed": "2.33 mph",
                    "wind_direction": "↘ SE",
                    "conditions": "overcast clouds",
                    "icon": "04n"
                }
            ]
        }
    }
}
```

**Background Image by Location**
`GET /api/v1/backgrounds?location=city,state`

This endpoint retrieves an image from the Unsplash API for the location query given. The endpoint also includes credit information for the author of the image and their website url. The response is returned in JSON format.

Response Example:
```
{
    "data": {
        "id": "null",
        "type": "background",
        "attributes": {
            "image": {
                "image_url": "https://images.unsplash.com/photo-1584289537662-27851fd5ab5b?crop=entropy&cs=srgb&fm=jpg&ixid=MXwxOTkzMzN8MHwxfHNlYXJjaHwxfHxkZW52ZXIsY298ZW58MXwwfHw&ixlib=rb-1.2.1&q=85"
            },
            "credit": {
                "author": "Sebastian Kurpiel",
                "source": [
                    "unsplash.com",
                    "Sebastian Kurpiel"
                ],
                "author_website": "https://unsplash.com/@sebbykurps"
            }
        }
    }
}
```

***
## Contributor
- Shaunda Cunningham ++ [![LinkedIn][linkedin-shield]](https://www.linkedin.com/in/shaunda-cunningham/) ++ [![GitHub][github-shield]](https://github.com/smcunning)

***
## Acknowledgements
This application utilizes the following free API data:
[MapQuest Geocoding API](https://developer.mapquest.com/documentation/geocoding-api/)
[OpenWeather Map One Call API](https://openweathermap.org/api/one-call-api)


<!-- MARKDOWN LINKS & IMAGES -->
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=flat-square&logo=linkedin&colorB=555
[github-shield]: https://img.shields.io/badge/-GitHub-black.svg?style=flat-square&logo=github&colorB=555
