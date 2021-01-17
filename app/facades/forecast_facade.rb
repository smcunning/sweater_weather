class ForecastFacade
  def self.forecast(city)
    ForecastSerializer.new(forecast_data(city))
  end

  def self.forecast_data(city)
    coords = city_coordinates(city)
    lat = coords[:lat]
    lon = coords[:lon]
    data = OpenWeatherService.forecast(lat, lon)
    Forecast.new(data)
  end

  def self.city_coordinates(city)
    coordinates = MapquestService.coordinates_by_city(city)
    {
      lat: coordinates[:results][0][:locations][0][:latLng][:lat],
      lon: coordinates[:results][0][:locations][0][:latLng][:lng]
    }
  end
end
