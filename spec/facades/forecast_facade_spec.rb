# frozen_string_literal: true

require 'rails_helper'

describe ForecastFacade do
  describe 'class methods' do
    it '.forecast' do
      VCR.use_cassette('mapquest_weather_combined') do
        forecast = ForecastFacade.forecast('denver,co')
        expect(forecast).to be_an_instance_of(ForecastSerializer)
      end
    end
  end
end
