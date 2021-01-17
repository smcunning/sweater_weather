# frozen_string_literal: true

class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  attribute :current_weather, &:current

  attribute :daily_weather do |forecast|
    forecast.daily[0..4].each do |day|
      day
    end
  end

  attribute :hourly_weather do |forecast|
    forecast.hourly[0..4].each do |hour|
      hour
    end
  end
end
