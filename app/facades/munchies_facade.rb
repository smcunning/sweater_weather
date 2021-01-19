class MunchiesFacade
  def self.munchies_at_destination(start_city, end_city, category)
    MunchiesSerializer.new()
  end

  def self.munchies_details(start_city, end_city, category)
    time = travel_time(start_city, end_city)
    hour = hour_at_destination(time).to_time.to_i
    weather = weather_at_eta(hour, end_city)
    restaurant = restaurant(end_city, hour, category)
    details = {
      destination_city: end_city,
      travel_time: time,
      forecast: weather,
      restaurant: restaurant
    }
    Munchie.new(details)
  end

  def self.restaurant(end_city, hour, category)
    restaurant = YelpService.businesses(end_city, hour, category)
    {
      name: restaurant[:businesses][0][:name],
      address: restaurant[:businesses][0][:location]
    }
  end

  def self.weather_at_eta(hour_at_destination, end_city)
    forecast = ForecastFacade.forecast_data(end_city)

    forecast_at_destination = forecast.hourly.find do |hourly_forecast|
      hourly_forecast.time == hour_at_destination.to_s[11..15]
      require "pry"; binding.pry
    end

    {
      summary: forecast_at_destination.conditions,
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
