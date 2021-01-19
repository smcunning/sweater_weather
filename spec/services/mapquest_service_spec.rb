# frozen_string_literal: true

require 'rails_helper'

describe MapquestService do
  context 'instance methods' do
    context '#coordinates_by_city' do
      it 'returns a longitude and latitude by a city name' do
        VCR.use_cassette('coordinates_by_city', record: :new_episodes) do
          @search = MapquestService.coordinates_by_city('denver,co')
        end

        expect(@search).to be_a Hash
        expect(@search).to have_key :results
        expect(@search[:results]).to be_an Array
        expect(@search[:results][0]).to have_key :locations
        expect(@search[:results][0][:locations]).to be_an Array
        expect(@search[:results][0][:locations][0]).to have_key :latLng
        expect(@search[:results][0][:locations][0][:latLng]).to be_a Hash
        expect(@search[:results][0][:locations][0][:latLng]).to have_key :lat
        expect(@search[:results][0][:locations][0][:latLng][:lat]).to be_a Float
        expect(@search[:results][0][:locations][0][:latLng]).to have_key :lng
        expect(@search[:results][0][:locations][0][:latLng][:lng]).to be_a Float
      end
    end

    context '#travel_time' do
      it 'returns a travel time based on start_city and end_city' do
        VCR.use_cassette('travel_time', record: :new_episodes) do
          @search = MapquestService.directions('denver,co', 'pueblo,co')
        end

        expect(@search).to be_a Hash
        expect(@search).to have_key :route
        expect(@search[:route]).to be_a Hash
        expect(@search[:route]).to have_key :formattedTime
        expect(@search[:route][:formattedTime]).to be_a String
      end
    end
  end
end
