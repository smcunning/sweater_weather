require 'rails_helper'

describe CurrentWeather do
  it 'exists with attributes' do
    data = {
       :dt=>1610865037,
       :sunrise=>1610806713,
       :sunset=>1610841641,
       :temp=>271.41,
       :feels_like=>265.98,
       :pressure=>1023,
       :humidity=>63,
       :dew_point=>265.98,
       :uvi=>0,
       :clouds=>100,
       :visibility=>10000,
       :wind_speed=>3.64,
       :wind_deg=>129,
       :weather=>
       [
         {
          :id=>804,
          :main=>"Clouds",
          :description=>"overcast clouds",
          :icon=>"04n"
         }
       ]
     }

    current = CurrentWeather.new(data)
    expect(current).to be_an_instance_of CurrentWeather
    expect(current.datetime).to be_a String
    expect(current.sunrise).to be_a String
    expect(current.sunset).to be_a String
    expect(current.temperature).to be_a Float
    expect(current.feels_like).to be_a Float
    expect(current.uvi).to be_a Integer
    expect(current.visibility).to be_a Integer
    expect(current.humidity).to be_a Integer
    expect(current.conditions).to be_a String
    expect(current.icon).to be_a String 
  end
end
