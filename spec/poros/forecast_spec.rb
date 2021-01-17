require 'rails_helper'

describe Forecast do
  it 'exists with attributes' do
    VCR.use_cassette('mapquest_weather_combined') do
      forecast = ForecastFacade.forecast_data('denver,co')

      expect(forecast.current).to be_an_instance_of CurrentWeather
      expect(forecast.hourly).to be_an Array
      expect(forecast.hourly[0]).to be_an_instance_of HourlyWeather
      expect(forecast.daily).to be_an Array
      expect(forecast.daily[0]).to be_an_instance_of DailyWeather
    end
  end
end
