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
      expect(road_trip.weather_at_eta[:conditions]).to be_a String
      expect(road_trip.weather_at_eta[:temperature]).to be_a Float
    end
  end

  it 'can convert_time_with_words' do
    VCR.use_cassette('road-trip-data') do
      details = {
        start_city: 'Denver,CO',
        end_city: 'Pueblo,CO',
        travel_time: {:formatted=>"01:44:22", :real=>6746},
        weather_at_eta: {:conditions=>"scattered clouds", :temperature=>32.16}
      }

      road_trip = RoadTrip.new(details)

      expect(road_trip.travel_time).to eq('1 hours, 44 minutes')

      details = {
        start_city: 'Denver,CO',
        end_city: 'Pueblo,CO',
        travel_time: {:formatted=>"11:44:22", :real=>6746},
        weather_at_eta: {:conditions=>"scattered clouds", :temperature=>32.16}
      }

      road_trip = RoadTrip.new(details)

      expect(road_trip.travel_time).to eq('11 hours, 44 minutes')
    end
  end
end
