class Forecast
  include Convertable
  attr_reader  :id,
               :current,
               :hourly,
               :daily

  def initialize(attributes)
    @id = 'null'
    @current = CurrentWeather.new(attributes[:current])
    @hourly = hourly_weather(attributes[:hourly])
    @daily = daily_weather(attributes[:daily])
  end

  def hourly_weather(data)
    data.map do |hour|
      HourlyWeather.new(hour)
    end
  end

  def daily_weather(data)
    data.map do |day|
      DailyWeather.new(day)
    end
  end
end
