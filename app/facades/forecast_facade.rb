class ForecastFacade
  def self.forecast(city)
    lat = city_coordinates(city)[:lat]
    lon = city_coordinates(city)[:lon]
    require "pry"; binding.pry
    ForecastSerializer.new(OpenWeatherService.forecast(lat, lon))
  end

  def self.city_coordinates(city)
    results = MapquestService.coordinates_by_city(city)
    {
      lat: results[:results][0][:locations][0][:latLng][:lat],
      lon: results[:results][0][:locations][0][:latLng][:lng]
    }
  end
end
