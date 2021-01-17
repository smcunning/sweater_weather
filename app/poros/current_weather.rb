class CurrentWeather
  include Convertable
  attr_reader :datetime,
              :sunrise,
              :sunset,
              :temperature,
              :feels_like,
              :humidity,
              :uvi,
              :visibility,
              :conditions,
              :icon
  def initialize(attributes)
    @datetime = convert_datetime(attributes[:dt])
    @sunrise = convert_datetime(attributes[:sunrise])
    @sunset = convert_datetime(attributes[:sunset])
    @temperature = attributes[:temp]
    @feels_like = attributes[:feels_like]
    @humidity = attributes[:humidity]
    @uvi= attributes[:uvi]
    @visibility = attributes[:visibility]
    @conditions = attributes[:weather][0][:description]
    @icon = attributes[:weather][0][:icon]
  end
end
