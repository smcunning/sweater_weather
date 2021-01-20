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

#Sad Path Testing - Coordinates
    context 'sad-paths' do
      it 'can find cities outside of the USA' do
        VCR.use_cassette('non-us-city-coordinates', record: :new_episodes) do
          @toronto = MapquestService.coordinates_by_city('toronto,on')
          @nairobi = MapquestService.coordinates_by_city('nairobi,kenya')
          @sydney = MapquestService.coordinates_by_city('sydney, australia')
        end

        expect(@toronto).to be_a Hash
        expect(@toronto).to have_key :results
        expect(@toronto[:results]).to be_an Array
        expect(@toronto[:results][0]).to have_key :locations
        expect(@toronto[:results][0][:locations]).to be_an Array
        expect(@toronto[:results][0][:locations][0]).to have_key :latLng
        expect(@toronto[:results][0][:locations][0][:latLng]).to be_a Hash
        expect(@toronto[:results][0][:locations][0][:latLng]).to have_key :lat
        expect(@toronto[:results][0][:locations][0][:latLng][:lat]).to be_a Float
        expect(@toronto[:results][0][:locations][0][:latLng]).to have_key :lng
        expect(@toronto[:results][0][:locations][0][:latLng][:lng]).to be_a Float

        expect(@nairobi).to be_a Hash
        expect(@nairobi).to have_key :results
        expect(@nairobi[:results]).to be_an Array
        expect(@nairobi[:results][0]).to have_key :locations
        expect(@nairobi[:results][0][:locations]).to be_an Array
        expect(@nairobi[:results][0][:locations][0]).to have_key :latLng
        expect(@nairobi[:results][0][:locations][0][:latLng]).to be_a Hash
        expect(@nairobi[:results][0][:locations][0][:latLng]).to have_key :lat
        expect(@nairobi[:results][0][:locations][0][:latLng][:lat]).to be_a Float
        expect(@nairobi[:results][0][:locations][0][:latLng]).to have_key :lng
        expect(@nairobi[:results][0][:locations][0][:latLng][:lng]).to be_a Float

        expect(@sydney).to be_a Hash
        expect(@sydney).to have_key :results
        expect(@sydney[:results]).to be_an Array
        expect(@sydney[:results][0]).to have_key :locations
        expect(@sydney[:results][0][:locations]).to be_an Array
        expect(@sydney[:results][0][:locations][0]).to have_key :latLng
        expect(@sydney[:results][0][:locations][0][:latLng]).to be_a Hash
        expect(@sydney[:results][0][:locations][0][:latLng]).to have_key :lat
        expect(@sydney[:results][0][:locations][0][:latLng][:lat]).to be_a Float
        expect(@sydney[:results][0][:locations][0][:latLng]).to have_key :lng
        expect(@sydney[:results][0][:locations][0][:latLng][:lng]).to be_a Float
      end

      it 'can find partial results' do
        VCR.use_cassette('partial-results-coordinates', record: :new_episodes) do
          @search = MapquestService.coordinates_by_city('denver')
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

      it 'returns no city name if a city does not exist' do
        VCR.use_cassette('no-mq-results', record: :new_episodes) do
          @search = MapquestService.coordinates_by_city('shaundaville')
        end

        expect(@search).to be_a Hash
        expect(@search[:results][0][:locations][0][:adminArea5]).to eq('')
      end

#Sad Path Testing - Directions
      it 'can find directions to cities outside the us' do
        VCR.use_cassette('non-us-city-directions') do
          @toronto = MapquestService.directions('denver,co', 'toronto, on')
        end

        expect(@toronto).to be_a Hash
        expect(@toronto).to have_key :route
        expect(@toronto[:route]).to be_a Hash
        expect(@toronto[:route]).to have_key :formattedTime
        expect(@toronto[:route][:formattedTime]).to be_a String
      end


      it 'returns an error message if it can not find a route' do
      VCR.use_cassette('non-us-city-directions') do
        @nairobi = MapquestService.directions('denver,co', 'nairobi,kenya')
        @sydney = MapquestService.directions('denver,co', 'sydney, australia')
      end

        expect(@nairobi).to be_a Hash
        expect(@nairobi).to have_key :info
        expect(@nairobi[:info][:statuscode]).to eq(402)
        expect(@nairobi[:info][:messages]).to be_an Array
        expect(@nairobi[:info][:messages][0]).to be_a String
        expect(@nairobi[:info][:messages][0]).to eq("We are unable to route with the given locations.")

        expect(@sydney).to be_a Hash
        expect(@sydney).to have_key :info
        expect(@sydney[:info][:statuscode]).to eq(402)
        expect(@sydney[:info][:messages]).to be_an Array
        expect(@sydney[:info][:messages][0]).to be_a String
        expect(@sydney[:info][:messages][0]).to eq("We are unable to route with the given locations.")
      end
    end
  end
end
