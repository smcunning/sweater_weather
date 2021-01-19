# frozen_string_literal: true

class RoadTripSerializer
  include FastJsonapi::ObjectSerializer
  set_type :roadtrip
  attribute :start_city, &:start_city
  attribute :end_city, &:end_city
  attribute :travel_time, &:travel_time
  attribute :weather_at_eta, &:weather_at_eta
end
