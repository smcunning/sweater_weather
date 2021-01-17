# frozen_string_literal: true

class OpenWeatherService
  def self.forecast(lat, lon)
    results = conn.get('/data/2.5/onecall?') do |req|
      req.params[:appid] = ENV['OPEN_WEATHER_API_KEY']
      req.params[:lat] = lat
      req.params[:lon] = lon
      req.params[:exclude] = 'minutely,alerts'
      req.params[:units] = 'imperial'
    end
    parse(results)
  end

  def self.conn
    Faraday.new(url: 'http://api.openweathermap.org')
  end

  def self.parse(results)
    JSON.parse(results.body, symbolize_names: true)
  end
end
