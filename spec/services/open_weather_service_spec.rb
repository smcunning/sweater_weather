# frozen_string_literal: true

require 'rails_helper'

describe OpenWeatherService do
  context 'instance methods' do
    context '#forecast' do
      it 'returns a set of forecast data by coordinates' do
        VCR.use_cassette('forecast_data', record: :new_episodes) do
          @search = OpenWeatherService.forecast(39.738453, -104.984853)
        end

        expect(@search).to be_a Hash

        # current
        expect(@search).to have_key :current
        expect(@search[:current]).to be_an Hash
        expect(@search[:current]).to have_key :dt
        expect(@search[:current][:dt]).to be_an Integer
        expect(@search[:current]).to have_key :sunrise
        expect(@search[:current][:sunrise]).to be_an Integer
        expect(@search[:current]).to have_key :sunset
        expect(@search[:current][:sunset]).to be_an Integer
        expect(@search[:current]).to have_key :feels_like
        expect(@search[:current][:feels_like]).to be_a Float
        expect(@search[:current]).to have_key :humidity
        expect(@search[:current][:humidity]).to be_an Integer
        expect(@search[:current]).to have_key :uvi
        expect(@search[:current]).to have_key :visibility
        expect(@search[:current][:visibility]).to be_an Integer
        expect(@search[:current]).to have_key :weather
        expect(@search[:current][:weather]).to be_an Array
        expect(@search[:current][:weather][0]).to have_key :description
        expect(@search[:current][:weather][0][:description]).to be_a String
        expect(@search[:current][:weather][0]).to have_key :icon
        expect(@search[:current][:weather][0][:icon]).to be_a String

        # results do not include certain weather data
        expect(@search).to_not have_key :minutely
        expect(@search).to_not have_key :alerts

        # hourly
        expect(@search.count).to eq(7)
        expect(@search[:hourly]).to be_an Array
        expect(@search[:hourly][0]).to have_key :dt
        expect(@search[:hourly][0][:dt]).to be_a Integer
        expect(@search[:hourly][0]).to have_key :temp
        expect(@search[:hourly][0][:temp]).to be_an Float
        expect(@search[:hourly][0]).to have_key :wind_speed
        expect(@search[:hourly][0][:wind_speed]).to be_an Float
        expect(@search[:hourly][0]).to have_key :wind_deg
        expect(@search[:hourly][0][:wind_deg]).to be_an Integer
        expect(@search[:hourly][0]).to have_key :weather
        expect(@search[:hourly][0][:weather]).to be_an Array
        expect(@search[:hourly][0][:weather][0]).to have_key :description
        expect(@search[:hourly][0][:weather][0][:description]).to be_a String
        expect(@search[:hourly][0][:weather][0]).to have_key :icon
        expect(@search[:hourly][0][:weather][0][:icon]).to be_a String

        # daily
        expect(@search.count).to eq(7)
        expect(@search[:daily]).to be_an Array
        expect(@search[:daily][0]).to have_key :dt
        expect(@search[:daily][0][:dt]).to be_an Integer
        expect(@search[:daily][0]).to have_key :sunrise
        expect(@search[:daily][0][:sunrise]).to be_an Integer
        expect(@search[:daily][0]).to have_key :sunset
        expect(@search[:daily][0][:sunset]).to be_an Integer
        expect(@search[:daily][0]).to have_key :temp
        expect(@search[:daily][0][:temp]).to be_a Hash
        expect(@search[:daily][0][:temp]).to have_key :max
        expect(@search[:daily][0][:temp][:max]).to be_a Float
        expect(@search[:daily][0][:temp]).to have_key :min
        expect(@search[:daily][0][:temp][:min]).to be_a Float
        expect(@search[:daily][0]).to have_key :weather
        expect(@search[:daily][0][:weather]).to be_an Array
        expect(@search[:daily][0][:weather][0]).to have_key :description
        expect(@search[:daily][0][:weather][0][:description]).to be_a String
        expect(@search[:daily][0][:weather][0]).to have_key :icon
        expect(@search[:daily][0][:weather][0][:icon]).to be_a String
      end
    end

    context 'sad paths' do
      it 'can find forecasts for cities outside of the US ' do
        VCR.use_cassette('non-us-city-forecast', record: :new_episodes) do
          @sweden = OpenWeatherService.forecast(60.1282, 18.6435)
          @tokyo = OpenWeatherService.forecast(35.6762, 139.6503)
        end

        expect(@sweden).to have_key :current
        expect(@sweden[:current]).to be_an Hash
        expect(@sweden[:current]).to have_key :dt
        expect(@sweden[:current][:dt]).to be_an Integer
        expect(@sweden.count).to eq(7)
        expect(@sweden[:hourly]).to be_an Array
        expect(@sweden[:hourly][0]).to have_key :dt
        expect(@sweden[:hourly][0][:dt]).to be_a Integer
        expect(@sweden.count).to eq(7)
        expect(@sweden[:daily]).to be_an Array
        expect(@sweden[:daily][0]).to have_key :dt
        expect(@sweden[:daily][0][:dt]).to be_an Integer

        expect(@tokyo).to have_key :current
        expect(@tokyo[:current]).to be_an Hash
        expect(@tokyo[:current]).to have_key :dt
        expect(@tokyo[:current][:dt]).to be_an Integer
        expect(@tokyo.count).to eq(7)
        expect(@tokyo[:hourly]).to be_an Array
        expect(@tokyo[:hourly][0]).to have_key :dt
        expect(@tokyo[:hourly][0][:dt]).to be_a Integer
        expect(@tokyo.count).to eq(7)
        expect(@tokyo[:daily]).to be_an Array
        expect(@tokyo[:daily][0]).to have_key :dt
        expect(@tokyo[:daily][0][:dt]).to be_an Integer
      end

      it 'can return an error with no params' do
        VCR.use_cassette('forecast-no-coords', record: :new_episodes) do
          @search = OpenWeatherService.forecast("","")
        end

        expect(@search).to have_key :message
        expect(@search).to have_key :cod
        expect(@search[:cod]).to eq("400")
        expect(@search[:message]).to eq('Nothing to geocode')
      end

      it 'can return an error with an incorrect lat/long' do
        VCR.use_cassette('forecast-wrong-coords', record: :new_episodes) do
          @search = OpenWeatherService.forecast("nothing","here")
        end

        expect(@search).to have_key :message
        expect(@search).to have_key :cod
        expect(@search[:cod]).to eq("400")
        expect(@search[:message]).to eq('wrong latitude')
      end
    end
  end
end
