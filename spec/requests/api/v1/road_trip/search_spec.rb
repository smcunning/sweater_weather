require 'rails_helper'

describe 'Road Trip Endpoint' do
  before(:each) do
    User.destroy_all

    # create a user to test api key requirements
    user_params = {
      email: 'example@example.com',
      password: 'password',
      password_confirmation: 'password'
    }

    headers = { 'CONTENT_TYPE' => 'application/json' }

    post '/api/v1/users', headers: headers, params: user_params, as: :json

    user = JSON.parse(response.body, symbolize_names: true)
    @api_key = user[:data][:attributes][:api_key]
  end
  it 'can return road trip data with an origin and destination request' do
    VCR.use_cassette('road-trip-data') do
      road_trip_params = {
        origin: "Denver,CO",
        destination: "Pueblo,CO",
        api_key: "#{@api_key}"
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v1/road_trip', headers: headers, params: road_trip_params, as: :json

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(response.content_type).to include('application/json')

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json).to have_key :data
      expect(json[:data]).to have_key :id
      expect(json[:data][:id]).to_not eq(nil)
      expect(json[:data][:id]).to be_a String
      expect(json[:data]).to have_key :type
      expect(json[:data][:type]).to eq('roadtrip')
      expect(json[:data]).to have_key :attributes
      expect(json[:data][:attributes]).to have_key :start_city
      expect(json[:data][:attributes][:start_city]).to be_a String
      expect(json[:data][:attributes]).to have_key :end_city
      expect(json[:data][:attributes][:end_city]).to be_a String
      expect(json[:data][:attributes]).to have_key :travel_time
      expect(json[:data][:attributes][:travel_time]).to be_a String
      expect(json[:data][:attributes]).to have_key :weather_at_eta
      expect(json[:data][:attributes][:weather_at_eta]).to be_a Hash
      expect(json[:data][:attributes][:weather_at_eta]).to have_key :temperature
      expect(json[:data][:attributes][:weather_at_eta][:temperature]).to be_a Float
      expect(json[:data][:attributes][:weather_at_eta]).to have_key :conditions
      expect(json[:data][:attributes][:weather_at_eta][:conditions]).to be_a String
    end
  end
end
