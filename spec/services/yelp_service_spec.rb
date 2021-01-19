# frozen_string_literal: true

require 'rails_helper'

describe YelpService do
  context 'instance methods' do
    it 'returns a list of businesses by location, category and open time' do
      VCR.use_cassette('yelp-business-search') do
        @search = YelpService.businesses('pueblo,co', 1611021600, 'chinese')
      end

      expect(@search).to be_a Hash
      expect(@search).to have_key :businesses
      expect(@search[:businesses]).to be_an Array
      expect(@search[:businesses][0]).to be_a Hash
      expect(@search[:businesses][0]).to have_key :name
      expect(@search[:businesses][0][:name]).to be_a String
      expect(@search[:businesses][0]).to have_key :location
      expect(@search[:businesses][0][:location]).to be_a Hash
      expect(@search[:businesses][0][:location]).to have_key :address1
      expect(@search[:businesses][0][:location][:address1]).to be_a String
      expect(@search[:businesses][0][:location]).to have_key :city
      expect(@search[:businesses][0][:location][:city]).to be_a String
      expect(@search[:businesses][0][:location]).to have_key :state
      expect(@search[:businesses][0][:location][:state]).to be_a String
      expect(@search[:businesses][0][:location]).to have_key :zip_code
      expect(@search[:businesses][0][:location][:zip_code]).to be_a String
    end
  end
end
