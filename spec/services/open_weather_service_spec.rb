require 'rails_helper'

escribe OpenWeatherService do
  context "instance methods" do
    context "#forecast" do
      it "returns a set of forecast data by coordinates" do
        VCR.use_cassette("coordinates_by_city") do
          VCR.use_cassette("forecast_data") do
            @search = OpenWeatherService.forecast(denver,co)
          end
        end

        expect(@search).to be_a Hash

        #current
        expect(@search).to have_key :current
        expect(@search[:current]).to be_an Hash
        expect(@search[:current]).to have_key :dt
        expect(@search[:current][:dt]).to be_an Integer
        expect(@search[:current]).to have_key :sunrise
        expect(@search[:current][:sunrise]).to be_an Integer
        expect(@search[:current]).to have_key :sunset
        expect(@search[:current][:sunset]).to be_an Integer
        expect(@search[:current]).to have_key :feels_like
        expect(@search[:current][:feels_like]).to be_an Integer
        expect(@search[:current]).to have_key :humidity
        expect(@search[:current][:humidity]).to be_an Integer
        expect(@search[:current]).to have_key :uvi
        expect(@search[:current][:uvi]).to be_an Integer
        expect(@search[:current]).to have_key :visibility
        expect(@search[:current][:visibility]).to be_an Integer
        expect(@search[:current]).to have_key :weather
        expect(@search[:current][:weather]).to be_an Array
        expect(@search[:current][:weather][0]).to have_key :description
        expect(@search[:current][:weather][0][:description]).to be_a String
        expect(@search[:current][:weather][0]).to have_key :icon
        expect(@search[:current][:weather][0][:icon]).to be_a String

        #results do not include "minutely" weather data
        expect(@search).to_not have_key :minutely

        #hourly
        expect(@search.count).to eq(8)
        expect(@search[:hourly]).to be an Array
        expect(@search[:hourly][0]).to have_key :dt
        expect(@search[:hourly][0][:dt]).to be_an Integer
        expect(@search[:hourly][0]).to have_key :temp
        expect(@search[:hourly][0][:temp]).to be_an Integer
        expect(@search[:hourly][0]).to have_key :wind_speed
        expect(@search[:hourly][0][:wind_speed]).to be_an Integer
        expect(@search[:hourly][0]).to have_key :wind_deg
        expect(@search[:hourly][0][:wind_deg]).to be_an Integer
        expect(@search[:hourly][0]).to have_key :weather
        expect(@search[:hourly][:weather][0]).to be_an Array
        expect(@search[:hourly][0][:weather][0]).to have_key :description
        expect(@search[:hourly][0][:weather][0][:description]).to be_a String
        expect(@search[:hourly][0][:weather][0]).to have_key :icon
        expect(@search[:hourly][0][:weather][0][:icon]).to be_a String

        #daily
        expect(@search.count).to eq(5)
        expect(@search[:daily]).to be an Array
        expect(@search[:daily][0]).to have_key :dt
        expect(@search[:daily][0][:dt]).to be_an Integer
        expect(@search[:daily][0]).to have_key :sunrise
        expect(@search[:daily][0][:sunrise]).to be_an Integer
        expect(@search[:daily][0]).to have_key :sunset
        expect(@search[:daily][0][:sunset]).to be_an Integer
        expect(@search[:daily][0]).to have_key :temp
        expect(@search[:daily][0][:temp]).to be_a Hash
        expect(@search[:daily][0][:temp]).to have_key :max
        expect(@search[:daily][0][:temp][:max]).to be_a Integer
        expect(@search[:daily][0][:temp]).to have_key :min
        expect(@search[:daily][0][:temp][:min]).to be_a Integer
        expect(@search[:daily][0]).to have_key :weather
        expect(@search[:daily][:weather][0]).to be_an Array
        expect(@search[:daily][0][:weather][0]).to have_key :description
        expect(@search[:daily][0][:weather][0][:description]).to be_a String
        expect(@search[:daily][0][:weather][0]).to have_key :icon
        expect(@search[:daily][0][:weather][0][:icon]).to be_a String
    end
  end
end
