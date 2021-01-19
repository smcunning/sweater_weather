# frozen_string_literal: true

require 'rails_helper'

describe RoadTripFacade do
  describe 'class methods' do
    it '.road_trip' do
      VCR.use_cassette('road-trip-data') do
        road_trip = RoadTripFacade.road_trip('Denver,CO', 'Pueblo,CO')
        expect(road_trip).to be_an_instance_of(RoadTripSerializer)
      end
    end

    it '.weather_at_eta' do
      VCR.use_cassette('mapquest_weather_combined') do
        time = '2021-01-18 23:00:00.000000000 -0700'
        data = RoadTripFacade.weather_at_eta(time, 'denver,co')
        expect(data).to be_a Hash
        expect(data).to have_key :conditions
        expect(data[:conditions]).to be_a String
        expect(data).to have_key :temperature
        expect(data[:temperature]).to be_a Float
      end
    end

    it '.hour_at_destination' do
      travel_time = {:formatted=>"01:44:22", :real=>6558}
      hour = RoadTripFacade.hour_at_destination(travel_time)
      expect(hour).to be_an_instance_of(Time)
    end

    it '.travel_time' do
      VCR.use_cassette('travel_time') do
        data = RoadTripFacade.travel_time('Denver,CO', 'Pueblo,CO')
        expect(data).to be_a Hash
      end
    end
  end
end
