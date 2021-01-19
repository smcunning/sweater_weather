# frozen_string_literal: true

class MunchieSerializer
  include FastJsonapi::ObjectSerializer
  set_type :munchie
  attribute :destination_city, &:destination_city
  attribute :travel_time, &:travel_time
  attribute :forecast, &:forecast
  attribute :restaurant, &:restaurant
end
