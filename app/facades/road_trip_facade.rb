# frozen_string_literal: true

class RoadTripFacade
  def self.road_trip(start_city, end_city)
    RoadTripSerializer.new(trip_details(start_city, end_city))
  end

  def self.trip_details(start_city, end_city)
    time = travel_time(start_city, end_city)

    if time[:formatted]
      hour = hour_at_destination(time)
      weather = weather_at_eta(hour, end_city)
      details = {
        start_city: start_city,
        end_city: end_city,
        travel_time: time,
        weather_at_eta: weather
      }
      RoadTrip.new(details)
    else
      details = {
        start_city: start_city,
        end_city: end_city,
        travel_time: "impossible",
        weather_at_eta: ""
      }
    end
  end

  def self.weather_at_eta(hour_at_destination, end_city)
    coords = ForecastFacade.city_coordinates(end_city)
    lat = coords[:results][0][:locations][0][:latLng][:lat]
    lon = coords[:results][0][:locations][0][:latLng][:lng]
    forecast = ForecastFacade.forecast_data(lat, lon)
require "pry"; binding.pry
    forecast_at_destination = forecast.hourly.find do |hourly_forecast|
      hourly_forecast.time == hour_at_destination.to_s[11..15]
    end

    {
      conditions: forecast_at_destination.conditions,
      temperature: forecast_at_destination.temperature
    }
  end

  def self.hour_at_destination(travel_time)
    current_time = Time.now.to_i
    Time.strptime((current_time + travel_time[:real]).to_s, '%s').beginning_of_hour
  end

  def self.travel_time(start_city, end_city)
    directions = MapquestService.directions(start_city, end_city)

    {
      formatted: directions[:route][:formattedTime],
      real: directions[:route][:realTime]
    }
  end
end
