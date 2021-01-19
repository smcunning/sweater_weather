# frozen_string_literal: true

class Munchie
  include Convertable
  attr_reader :id,
              :destination_city,
              :travel_time,
              :forecast,
              :restaurant

  def initialize(attributes)
    @id = 'null'
    @destination_city = attributes[:destination_city]
    @travel_time = convert_time_with_words(attributes[:travel_time][:formatted])
    @forecast = convert_temperature(attributes[:forecast])
    @restaurant = attributes[:restaurant]
  end
end
