# frozen_string_literal: true

describe HourlyWeather do
  it 'exists with attributes' do
    data = {
      dt: 1_610_863_200,
      temp: 271.41,
      feels_like: 265.98,
      pressure: 1023,
      humidity: 63,
      dew_point: 265.98,
      uvi: 0,
      clouds: 100,
      visibility: 10_000,
      wind_speed: 3.64,
      wind_deg: 129,
      weather: [
        {
          id: 804,
          main: 'Clouds',
          description: 'overcast clouds',
          icon: '04n'
        }
      ]
    }

    hourly = HourlyWeather.new(data)
    expect(hourly).to be_an_instance_of HourlyWeather
    expect(hourly.time).to be_a String
    expect(hourly.temperature).to be_a Float
    expect(hourly.wind_speed).to be_a String
    expect(hourly.wind_direction).to be_a String
    expect(hourly.conditions).to be_a String
    expect(hourly.icon).to be_a String
  end
end
