# frozen_string_literal: true

require 'rails_helper'

describe 'Backgrounds by Location Endpoint' do
  it 'can return the an image for the location' do
    VCR.use_cassette('denver-photos') do
      get '/api/v1/backgrounds?location=denver,co'

      expect(response).to be_successful

      image_data = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(image_data).to be_a Hash
      expect(image_data).to have_key :id
      expect(image_data[:id]).to eq('null')
      expect(image_data).to have_key :type
      expect(image_data[:type]).to eq('background')
      expect(image_data).to have_key :attributes
      expect(image_data[:attributes]).to have_key :image
      expect(image_data[:attributes][:image]).to have_key :image_url
      expect(image_data[:attributes][:image][:image_url]).to be_a String
      expect(image_data[:attributes]).to have_key :credit
      expect(image_data[:attributes][:credit]).to be_a Hash
      expect(image_data[:attributes][:credit]).to have_key :author
      expect(image_data[:attributes][:credit][:author]).to be_a String
      expect(image_data[:attributes][:credit]).to have_key :source
      expect(image_data[:attributes][:credit][:source]).to be_a String
      expect(image_data[:attributes][:credit]).to have_key :author_website
      expect(image_data[:attributes][:credit][:author_website]).to be_a String
    end
  end

#Sad Path Testing
  it 'returns an error for invalid location queries' do
    VCR.use_cassette('partial-photos-invalid') do
      get '/api/v1/backgrounds?location=denv'

      data = JSON.parse(response.body, symbolize_names: true)
      require "pry"; binding.pry
    end
  end
end
