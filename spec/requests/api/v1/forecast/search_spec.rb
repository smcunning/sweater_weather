# frozen_string_literal: true

require 'rails_helper'

describe 'Forecast by Location Endpoint' do
  it 'can return the weather forecast for a city' do
    VCR.use_cassette('mapquest_weather_combined', record: :new_episodes) do
      get '/api/v1/forecast?location=denver,co'

      expect(response).to be_successful

      forecast = JSON.parse(response.body, symbolize_names: true)[:data]
      expect(forecast).to be_a Hash
      expect(forecast[:id]).to eq('null')
      expect(forecast[:type]).to eq('forecast')

      # current_weather
      expect(forecast[:attributes][:current_weather]).to be_a Hash
      expect(forecast[:attributes][:current_weather][:datetime]).to be_a String
      expect(forecast[:attributes][:current_weather][:sunrise]).to be_a String
      expect(forecast[:attributes][:current_weather][:sunset]).to be_a String
      expect(forecast[:attributes][:current_weather][:temperature]).to be_a Float
      expect(forecast[:attributes][:current_weather][:feels_like]).to be_a Float
      expect(forecast[:attributes][:current_weather][:humidity]).to be_a Integer
      expect(forecast[:attributes][:current_weather][:visibility]).to be_a Integer
      expect(forecast[:attributes][:current_weather][:conditions]).to be_a String
      expect(forecast[:attributes][:current_weather][:icon]).to be_a String

      # daily_weather
      expect(forecast[:attributes][:daily_weather]).to be_an Array
      expect(forecast[:attributes][:daily_weather][0][:date]).to be_a String
      expect(forecast[:attributes][:daily_weather][0][:sunrise]).to be_a String
      expect(forecast[:attributes][:daily_weather][0][:sunset]).to be_a String
      expect(forecast[:attributes][:daily_weather][0][:max_temp]).to be_a Float
      expect(forecast[:attributes][:daily_weather][0][:min_temp]).to be_a Float
      expect(forecast[:attributes][:daily_weather][0][:conditions]).to be_a String
      expect(forecast[:attributes][:daily_weather][0][:icon]).to be_a String

      # hourly_weather
      expect(forecast[:attributes][:hourly_weather]).to be_an Array
      expect(forecast[:attributes][:hourly_weather][0][:time]).to be_a String
      expect(forecast[:attributes][:hourly_weather][0][:temperature]).to be_a Float
      expect(forecast[:attributes][:hourly_weather][0][:wind_speed]).to be_a String
      expect(forecast[:attributes][:hourly_weather][0][:wind_direction]).to be_a String
      expect(forecast[:attributes][:hourly_weather][0][:conditions]).to be_a String
      expect(forecast[:attributes][:hourly_weather][0][:icon]).to be_a String
    end
  end

#Sad Path Testing

  it 'returns an error if the location is missing' do
    VCR.use_cassette(`forecast-no-location`, record: :new_episodes) do
      get '/api/v1/forecast?location'

      expect(response.status).to eq(400)

      forecast = JSON.parse(response.body, symbolize_names: true)

      expect(forecast).to be_a Hash
      expect(forecast[:message]).to eq('unsuccessful')
      expect(forecast[:error]).to eq('Location not found.')
    end
  end

  it 'returns an error if a location cant be found' do
    VCR.use_cassette('forecast-location-not-found', record: :new_episodes) do
      get '/api/v1/forecast?location=#$2341dadf'

      forecast = JSON.parse(response.body, symbolize_names: true)

      expect(forecast).to be_a Hash
      expect(forecast[:message]).to eq('unsuccessful')
      expect(forecast[:error]).to eq('Location not found.')
    end
  end
end
