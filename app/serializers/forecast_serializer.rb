class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  attribute :current_weather do |forecast|
    forecast.current
  end

  attribute :daily_weather do |forecast|
    forecast[0..4].daily.each do |day|
      day
    end
  end

  attribute :hourly_weather do |forecast|
    forecast[0..7].hourly.each do |hour|
      hour
    end
  end
end
