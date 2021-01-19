# frozen_string_literal: true

require 'rails_helper'

describe RoadTrip do
  it 'exists with attributes' do
    VCR.use_cassette('road-trip-data') do
      road_trip = RoadTripFacade.trip_details('Denver,CO', 'Pueblo,CO')
      expect(road_trip).to be_an_instance_of RoadTrip

      expect(road_trip.start_city).to be_a String
      expect(road_trip.end_city).to be_a String
      expect(road_trip.travel_time).to be_a String
      expect(road_trip.weather_at_eta).to be_a Hash
      expect(roadtrip.weather_at_eta[:conditions]).to be_a String
      expect(roadtrip.weather_at_eta[:temperature]).to be_a Float
    end
  end

  it 'can convert_time_with_words' do
    VCR.use_cassette('road-trip-data') do
      road_trip = RoadTripFacade.trip_details('Denver,CO', 'Pueblo,CO')
      expect(road_trip).to be_an_instance_of RoadTrip

      expect(road_trip.start_city).to be_a String
      expect(road_trip.end_city).to be_a String
      expect(road_trip.travel_time).to be_a String
      expect(road_trip.weather_at_eta).to be_a Hash
      expect(roadtrip.weather_at_eta[:conditions]).to be_a String
      expect(roadtrip.weather_at_eta[:temperature]).to be_a Float
  end
end
