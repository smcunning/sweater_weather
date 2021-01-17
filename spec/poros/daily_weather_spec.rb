require 'rails_helper'

describe DailyWeather do
  it 'exists with attributes' do
    data = {
      :dt=>1610823600,
      :sunrise=>1610806713,
      :sunset=>1610841641,
      :temp=>{
        :day=>279.38,
        :min=>271.41,
        :max=>280.0,
        :night=>271.41,
        :eve=>276.54,
        :morn=>274.18
      },
     :feels_like=>{
       :day=>275.72,
       :night=>265.98,
       :eve=>272.01,
       :morn=>271.09
      },
     :pressure=>1019,
     :humidity=>60,
     :dew_point=>269.47,
     :wind_speed=>2.2,
     :wind_deg=>124,
     :weather=>[
      {
        :id=>800,
        :main=>"Clear",
        :description=>"clear sky",
        :icon=>"01d"
        }
      ],
    :clouds=>0,
    :pop=>0.16,
    :uvi=>1.9
  }

    daily = DailyWeather.new(data)
    expect(daily).to be_an_instance_of DailyWeather
    expect(daily.date).to be_a String
    expect(daily.sunrise).to be_a String
    expect(daily.sunset).to be_a String
    expect(daily.max_temp).to be_a Float
    expect(daily.min_temp).to be_a Float
    expect(daily.conditions).to be_a String
    expect(daily.icon).to be_a String
  end
end
