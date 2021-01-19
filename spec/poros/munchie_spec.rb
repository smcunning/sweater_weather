# frozen_string_literal: true

require 'rails_helper'

describe Munchie do
  it 'exists with attributes' do
    VCR.use_cassette('munchies-data') do
      munchie = MunchiesFacade.munchies_details('denver,co', 'pueblo,co', 'chinese')

      expect(munchie.id).to eq('null')
      expect(munchie.forecast).to be_a Hash
      expect(munchie.forecast).to have_key :summary
      expect(munchie.forecast[:summary]).to be_a String
      expect(munchie.forecast).to have_key :temperature
      expect(munchie.forecast[:temperature]).to be_a Integer
      expect(munchie.travel_time).to be_a String
      expect(munchie.destination_city).to be_a String
      expect(munchie.restaurant).to be_a Hash
      expect(munchie.restaurant).to have_key :name
      expect(munchie.restaurant[:name]).to be_a String
      expect(munchie.restaurant).to have_key :address
      expect(munchie.restaurant[:address]).to be_a String
    end
  end

  it 'can convert_temperature' do
    details = {
      destination_city: 'Pueblo, CO',
      travel_time: { formatted: '01:44:22', real: 6558 },
      forecast: { summary: 'scattered clouds', temperature: 33.19 },
      restaurant: { name: 'Bingo Burger', address: '101 Central Plz and Pueblo, CO 81003' }
    }

    munchie = Munchie.new(details)

    expect(munchie.forecast).to eq({ summary: 'scattered clouds', temperature: 33 })
  end
end
