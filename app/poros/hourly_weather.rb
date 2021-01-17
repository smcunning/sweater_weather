class HourlyWeather
  include Convertable
  attr_reader :time,
              :temperature,
              :wind_speed,
              :wind_direction,
              :conditions,
              :icon
  def initialize(attributes)
    @time = convert_time(attributes[:dt])
    @temperature = attributes[:temp]
    @wind_speed= convert_wind_speed(attributes[:wind_speed])
    @wind_direction = convert_wind_degrees(attributes[:wind_deg])
    @conditions = attributes[:weather][0][:description]
    @icon = attributes[:weather][0][:icon]
  end
end
