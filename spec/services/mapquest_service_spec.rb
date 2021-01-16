require 'rails_helper'

describe MapQuestService do
  context "instance methods" do
    context "#coordinates_by_city" do
      it "returns a longitude and latitude by a city name" do
        VCR.use_cassette("coordinates_by_city") do
          @search = MapQuestService.coordinates_by_city("denver,co")
        end

        expect(@search).to be_a Hash
        expect(@search).to have_key :results
        expect(@search[:results]).to be_an Array
        expect(@search[:results]).to have_key :locations
        expect(@search[:results][:locations]).to be_an Array
        expect(@search[:results][:locations]).to have_key :latLng
        expect(@search[:results][:locations][:latLng]).to be_a Hash
        expect(@search[:results][:locations][:latLng]).to have_key :lat
        expect(@search[:results][:locations][:latLng][:lat]).to be_a Float
        expect(@search[:results][:locations][:latLng]).to have_key :lng
        expect(@search[:results][:locations][:latLng][:lng]).to be_a Float
      end
    end
  end
end
