class DailyWeather
  include Convertable
  attr_reader :date,
              :sunrise,
              :sunset,
              :max_temp,
              :min_temp,
              :conditions,
              :icon
  def initialize(attributes)
    @date = convert_date(attributes[:dt])
    @sunrise = convert_datetime(attributes[:sunrise])
    @sunset = convert_datetime(attributes[:sunset])
    @max_temp = attributes[:temp][:max]
    @min_temp = attributes[:temp][:min]
    @conditions = attributes[:weather][0][:description]
    @icon = attributes[:weather][0][:icon]
  end
end
