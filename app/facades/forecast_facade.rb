# frozen_string_literal: true

class ForecastFacade
  def self.forecast(city)
    coords = city_coordinates(city)
    if coords[:info][:statuscode] == 400
      { message: 'unsuccessful', error: 'Location not found.' }
    else
      lat = coords[:results][0][:locations][0][:latLng][:lat]
      lon = coords[:results][0][:locations][0][:latLng][:lng]
      data = forecast_data(lat, lon)
      ForecastSerializer.new(data)
    end
  end

  def self.forecast_data(lat, lon)
    data = OpenWeatherService.forecast(lat, lon)
    Forecast.new(data)
  end

  def self.city_coordinates(city)
    MapquestService.coordinates_by_city(city)
  end
end
