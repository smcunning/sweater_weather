require 'rails_helper'

describe MunchiesFacade do
  describe 'class methods' do
    it '.munchies_at_destination' do
      VCR.use_cassette('munchies-data') do
        munchie = MunchiesFacade.munchies_at_destination('denver,co', 'pueblo,co', 'chinese')
        expect(munchie).to be_an_instance_of(MunchieSerializer)
      end
    end

    it '.munchies_details' do
      VCR.use_cassette('munchies-data') do
        data = MunchiesFacade.munchies_details('denver,co', 'pueblo,co', 'chinese')
        expect(data).to be_an_instance_of(Munchie)
      end
    end

    it '.restaurant' do
      VCR.use_cassette('yelp-business-search') do
        restaurant = MunchiesFacade.restaurant('denver,co', 1611075600, 'chinese')
        expect(restaurant).to be_a Hash
        expect(restaurant).to have_key :name
        expect(restaurant[:name]).to be_a String
        expect(restaurant).to have_key :address
        expect(restaraunt[:address]).to be_a Hash
      end
    end

    it '.weather_at_eta' do
      VCR.use_cassette('munchies_weather') do
        time = '2021-01-18 10:00:00.000000000 -0700'
        data = MunchiesFacade.weather_at_eta(time, 'pueblo,co')
        expect(data).to be_a Hash
        expect(data).to have_key :summary
        expect(data[:conditions]).to be_a String
        expect(data).to have_key :temperature
        expect(data[:temperature]).to be_a Float
      end
    end

    it '.hour_at_destination' do
      travel_time = {:formatted=>"01:44:22", :real=>6558}
      hour = MunchiesFacade.hour_at_destination(travel_time)
      expect(hour).to be_an_instance_of(Time)
    end

    it '.travel_time' do
      VCR.use_cassette('travel_time') do
        data = MunchiesFacade.travel_time('Denver,CO', 'Pueblo,CO')
        expect(data).to be_a Hash
      end
    end
  end
end
