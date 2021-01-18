require 'rails_helper'

describe 'User Registration Endpoint' do
  before(:each) do
    User.destroy_all
  end
  it 'can create a user with a unique API key' do
    user_params = {
                    email: "example@example.com",
                    password: "password",
                    password_confirmation: "password"
    }

    headers = {"CONTENT_TYPE" => "application/json"}

    post '/api/v1/users', headers: headers, params: JSON.generate(user_params)
    created_user = User.last
    expect(response).to be_successful
    expect(response.status).to eq(201)
    expect(response.content_type).to include("application/json")

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json).to have_key :data
    expect(json[:data]).to have_key :id
    expect(json[:data][:id]).to_not eq(nil)
    expect(json)[:data][:id].to be_a String
    expect(json[:data]).to have_key :type
    expect(json[:data][:type]).to eq('users')
    expect(json[:data]).to have_key :attributes
    expec(json[:data][:attributes]).to have_key :email
    expec(json[:data][:attributes]).to have_key :api_key
    expec(json[:data][:attributes]).to_not include(:password)
    expec(json[:data][:attributes]).to_not include(:password_digest)
  end
end
