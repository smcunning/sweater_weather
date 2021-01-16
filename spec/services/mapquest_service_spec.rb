require 'rails_helper'

describe MapquestService do
  context "instance methods" do
    context "#coordinates_by_city" do
      it "returns a longitude and latitude by a city name" do
        VCR.use_cassette("coordinates_by_city") do
          @search = MapquestService.coordinates_by_city("denver,co")
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
  end
end
