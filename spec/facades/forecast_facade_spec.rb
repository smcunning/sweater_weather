# frozen_string_literal: true

require 'rails_helper'

describe ForecastFacade do
  describe 'class methods' do
    it '.city_coordinates' do
      VCR.use_cassette('coordinates_by_city') do
        coords = ForecastFacade.city_coordinates('denver,co')
        expect(coords).to be_a Hash
        expect(coords).to have_key :lat
        expect(coords[:lat]).to be_a Float
        expect(coords).to have_key :lon
        expect(coords[:lon]).to be_a Float
      end
    end

    it '.forecast_data' do
      VCR.use_cassette('mapquest_weather_combined') do
        data = ForecastFacade.forecast_data('denver,co')
        expect(data).to be_an_instance_of(Forecast)
      end
    end

    it '.forecast' do
      VCR.use_cassette('mapquest_weather_combined') do
        forecast = ForecastFacade.forecast('denver,co')
        expect(forecast).to be_an_instance_of(ForecastSerializer)
      end
    end
  end
end
