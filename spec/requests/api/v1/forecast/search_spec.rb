require 'rails_helper'

describe 'Forecast by Location Endpoint' do
  it 'can return the weather forecast for a city' do
    get '/api/v1/forecast?location=denver,co'

    expect(response).to be_successful

    forecast = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(forecast).to be_a Hash
    expect(forecast)[:id].to be_null
    expect(forecast)[:type].to eq('forecast')

    #current_weather
    expect(forecast)[:attributes][:current_weather].to be_an Array
    expect(forecast)[:attributes][:current_weather][:datetime].to be_a String
    expect(forecast)[:attributes][:current_weather][:sunrise].to be_a String
    expect(forecast)[:attributes][:current_weather][:sunset].to be_a String
    expect(forecast)[:attributes][:current_weather][:temperature].to be_a Float
    expect(forecast)[:attributes][:current_weather][:feels_like].to be_a Float
    expect(forecast)[:attributes][:current_weather][:humidity].to be_a Integer
    expect(forecast)[:attributes][:current_weather][:uvi].to be_a Integer
    expect(forecast)[:attributes][:current_weather][:visibility].to be_a Integer
    expect(forecast)[:attributes][:current_weather][:conditions].to be_a String
    expect(forecast)[:attributes][:current_weather][:icon].to be_a String

    #daily_weather
    expect(forecast)[:attributes][:daily_weather].to be_an Array
    expect(forecast)[:attributes][:daily_weather][:date].to be_a String
    expect(forecast)[:attributes][:daily_weather][:sunrise].to be_a String
    expect(forecast)[:attributes][:daily_weather][:sunset].to be_a String
    expect(forecast)[:attributes][:daily_weather][:max_temp].to be_a Float
    expect(forecast)[:attributes][:daily_weather][:min_temp].to be_a Float
    expect(forecast)[:attributes][:daily_weather][:conditions].to be_a String
    expect(forecast)[:attributes][:daily_weather][:icon].to be_a String

    #hourly_weather
    expect(forecast)[:attributes][:hourly_weather].to be_an Array
    expect(forecast)[:attributes][:hourly_weather][:time].to be_a String
    expect(forecast)[:attributes][:hourly_weather][:temperature].to be_a Float
    expect(forecast)[:attributes][:hourly_weather][:wind_speed].to be_a String
    expect(forecast)[:attributes][:hourly_weather][:wind_direction].to be_a String
    expect(forecast)[:attributes][:hourly_weather][:conditions].to be_a String
    expect(forecast)[:attributes][:hourly_weather][:icon].to be_a String
  end
end
