# frozen_string_literal: true

require 'rails_helper'

describe Forecast do
  it 'exists with attributes' do
    data = {
     :lat=>39.7385,
     :lon=>-104.9849,
     :timezone=>"America/Denver",
     :timezone_offset=>-25200,
     :current=>
      {:dt=>1611089219,
       :sunrise=>1611065827,
       :sunset=>1611101043,
       :temp=>37.9,
       :feels_like=>29.64,
       :pressure=>1031,
       :humidity=>34,
       :dew_point=>14.23,
       :uvi=>1.16,
       :clouds=>83,
       :visibility=>10000,
       :wind_speed=>4.65,
       :wind_deg=>159,
       :weather=>[{:id=>803, :main=>"Clouds", :description=>"broken clouds", :icon=>"04d"}]},
     :hourly=>
      [{:dt=>1611086400,
        :temp=>37.9,
        :feels_like=>29.64,
        :pressure=>1031,
        :humidity=>34,
        :dew_point=>14.23,
        :uvi=>1.67,
        :clouds=>83,
        :visibility=>10000,
        :wind_speed=>4.65,
        :wind_deg=>159,
        :weather=>[{:id=>803, :main=>"Clouds", :description=>"broken clouds", :icon=>"04d"}],
        :pop=>0},
       {:dt=>1611090000,
        :temp=>36.61,
        :feels_like=>29.03,
        :pressure=>1030,
        :humidity=>50,
        :dew_point=>21.13,
        :uvi=>1.16,
        :clouds=>81,
        :visibility=>10000,
        :wind_speed=>4.54,
        :wind_deg=>106,
        :weather=>[{:id=>803, :main=>"Clouds", :description=>"broken clouds", :icon=>"04d"}],
        :pop=>0}],
        :daily=>
         [{:dt=>1611082800,
           :sunrise=>1611065827,
           :sunset=>1611101043,
           :temp=>{:day=>32.67, :min=>28.22, :max=>37.9, :night=>31.91, :eve=>33.78, :morn=>28.71},
           :feels_like=>{:day=>25.61, :night=>25.41, :eve=>29.12, :morn=>22.62},
           :pressure=>1032,
           :humidity=>72,
           :dew_point=>6.62,
           :wind_speed=>4.52,
           :wind_deg=>173,
           :weather=>[{:id=>804, :main=>"Clouds", :description=>"overcast clouds", :icon=>"04d"}],
           :clouds=>100,
           :pop=>0.39,
           :uvi=>1.87},
          {:dt=>1611169200,
           :sunrise=>1611152195,
           :sunset=>1611187512,
           :temp=>{:day=>47.25, :min=>32.04, :max=>51.15, :night=>38.14, :eve=>43.84, :morn=>32.67},
           :feels_like=>{:day=>41.27, :night=>30.83, :eve=>37.27, :morn=>24.51},
           :pressure=>1015,
           :humidity=>46,
           :dew_point=>16.03,
           :wind_speed=>3.18,
           :wind_deg=>188,
           :weather=>[{:id=>800, :main=>"Clear", :description=>"clear sky", :icon=>"01d"}],
           :clouds=>0,
           :pop=>0,
           :uvi=>1.97},
          {:dt=>1611255600,
           :sunrise=>1611238560,
           :sunset=>1611273981,
           :temp=>{:day=>43.16, :min=>34.05, :max=>45.52, :night=>34.68, :eve=>41.49, :morn=>34.59},
           :feels_like=>{:day=>37.38, :night=>29.71, :eve=>35.35, :morn=>29.43},
           :pressure=>1015,
           :humidity=>55,
           :dew_point=>17.76,
           :wind_speed=>2.95,
           :wind_deg=>118,
           :weather=>[{:id=>800, :main=>"Clear", :description=>"clear sky", :icon=>"01d"}],
           :clouds=>4,
           :pop=>0,
           :uvi=>2.07}]
         }


      forecast = Forecast.new(data)
      expect(forecast.current).to be_an_instance_of CurrentWeather
      expect(forecast.hourly).to be_an Array
      expect(forecast.hourly[0]).to be_an_instance_of HourlyWeather
      expect(forecast.daily).to be_an Array
      expect(forecast.daily[0]).to be_an_instance_of DailyWeather
  end
end
