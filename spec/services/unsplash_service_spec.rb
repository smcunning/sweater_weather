require 'rails_helper'

describe UnsplashService do
  context 'instance methods' do
    it 'returns photos based on a search query' do
      VCR.use_cassette('denver-photos', record: :new_episodes) do
        @search = UnsplashService.location_photos('denver,co')
      end

      expect(@search).to be_a Hash
      expect(@search).to have_key :results
      expect(@search[:results]).to be_a Array
      expect(@search[:results][0]).to be_a Hash
      expect(@search[:results][0]).to have_key :urls
      expect(@search[:results][0][:urls]).to be_a Hash
      expect(@search[:results][0][:urls]).to have_key :full
      expect(@search[:results][0][:urls][:full]).to be_a String
      expect(@search[:results][0]).to have_key :alt_description
      expect(@search[:results][0][:alt_description]).to be_a String
      expect(@search[:results][0]).to have_key :user
      expect(@search[:results][0][:user]).to be_a Hash
      expect(@search[:results][0][:user]).to have_key :first_name
      expect(@search[:results][0][:user][:first_name]).to be_a String
      expect(@search[:results][0][:user]).to have_key :last_name
      expect(@search[:results][0][:user][:last_name]).to be_a String
      expect(@search[:results][0][:user]).to have_key :links
      expect(@search[:results][0][:user][:links]).to be_a Hash
      expect(@search[:results][0][:user][:links]).to have_key :html
      expect(@search[:results][0][:user][:links][:html]).to be_a String
    end
  end
end
