class HourlyWeather
  attr_reader :time,
              :temperature,
              :wind_speed,
              :wind_direction,
              :conditions,
              :icon
  def initialize(attributes)
    @time = attributes[:dt]
    @temperature = attributes[:temp]
    @wind_speed= attributes[:wind_speed]
    @wind_direction = attributes[:wind_deg]
    @conditions = attributes[:weather][0][:description]
    @icon = attributes[:weather][0][:description]
  end
end
