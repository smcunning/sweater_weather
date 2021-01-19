# frozen_string_literal: true

require 'rails_helper'

describe 'Munchies Endpoint' do
  it 'can return restaurant data with an origin, destination and cuisine request' do
    VCR.use_cassette('munchies-data', record: :new_episodes) do
      headers = { 'CONTENT_TYPE' => 'application/json' }

      get '/api/v1/munchies?start=denver,co&end=pueblo,co&food=chinese', headers: headers

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(response.content_type).to include('application/json')

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json).to have_key :data
      expect(json[:data]).to have_key :id
      expect(json[:data][:id]).to_not eq(nil)
      expect(json[:data][:id]).to be_a String
      expect(json[:data]).to have_key :type
      expect(json[:data][:type]).to eq('munchie')
      expect(json[:data]).to have_key :attributes
      expect(json[:data][:attributes]).to have_key :destination_city
      expect(json[:data][:attributes][:destination_city]).to be_a String
      expect(json[:data][:attributes]).to have_key :travel_time
      expect(json[:data][:attributes][:travel_time]).to be_a String
      expect(json[:data][:attributes]).to have_key :forecast
      expect(json[:data][:attributes][:forecast]).to be_a Hash
      expect(json[:data][:attributes][:forecast]).to have_key :summary
      expect(json[:data][:attributes][:forecast][:summary]).to be_a String
      expect(json[:data][:attributes][:forecast]).to have_key :temperature
      expect(json[:data][:attributes][:forecast][:temperature]).to be_an Integer
      expect(json[:data][:attributes]).to have_key :restaurant
      expect(json[:data][:attributes][:restaurant]).to be_a Hash
      expect(json[:data][:attributes][:restaurant]).to have_key :name
      expect(json[:data][:attributes][:restaurant][:name]).to be_a String
      expect(json[:data][:attributes][:restaurant]).to have_key :address
      expect(json[:data][:attributes][:restaurant][:address]).to be_a String
    end
  end

  it 'returns an error message when origin, destination or food are left blank' do
  end

  it 'returns an error message when all restaurants are closed at the eta' do
  end 
end
