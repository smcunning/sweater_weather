class RoadTrip
  include Convertable
  attr_reader :id,
              :start_city,
              :end_city,
              :travel_time,
              :weather_at_eta

  def initialize(attributes)
    @id = 'null'
    @start_city = attributes[:start_city]
    @end_city = attributes[:end_city]
    @travel_time = convert_time_with_words(attributes[:travel_time][:formatted])
    @weather_at_eta = attributes[:weather_at_eta]
  end
end
