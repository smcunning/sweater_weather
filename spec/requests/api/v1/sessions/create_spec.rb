# frozen_string_literal: true

require 'rails_helper'

describe 'Login Endpoint' do
  before(:each) do
    User.destroy_all

    # create a user to test login
    user_params = {
      email: 'example@example.com',
      password: 'password',
      password_confirmation: 'password'
    }

    headers = { 'CONTENT_TYPE' => 'application/json' }

    post '/api/v1/users', headers: headers, params: user_params, as: :json
  end

  it 'can login a registered user' do
    login_params = {
      email: 'example@example.com',
      password: 'password'
    }

    headers = { 'CONTENT_TYPE' => 'application/json' }

    post '/api/v1/sessions', headers: headers, params: login_params, as: :json

    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(response.content_type).to include('application/json')

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json).to have_key :data
    expect(json[:data]).to have_key :id
    expect(json[:data][:id]).to_not eq(nil)
    expect(json[:data][:id]).to be_a String
    expect(json[:data]).to have_key :type
    expect(json[:data][:type]).to eq('user')
    expect(json[:data]).to have_key :attributes
    expect(json[:data][:attributes]).to have_key :email
    expect(json[:data][:attributes]).to have_key :api_key
    expect(json[:data][:attributes]).to_not include(:password)
    expect(json[:data][:attributes]).to_not include(:password_digest)
  end

  it 'cannot login an unregistered user' do
    login_params = {
      email: 'example1@example.com',
      password: 'password'
    }

    headers = { 'CONTENT_TYPE' => 'application/json' }

    post '/api/v1/sessions', headers: headers, params: login_params, as: :json

    expect(response.status).to eq(401)
    expect(response.content_type).to include('application/json')

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json[:message]).to eq('unsuccessful')
    expect(json[:error]).to eq('Credentials are bad.')
  end

  it 'cannot login a user with incorrect password' do
    login_params = {
      email: 'example@example.com',
      password: 'password1'
    }

    headers = { 'CONTENT_TYPE' => 'application/json' }

    post '/api/v1/sessions', headers: headers, params: login_params, as: :json

    expect(response.status).to eq(401)
    expect(response.content_type).to include('application/json')

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json[:message]).to eq('unsuccessful')
    expect(json[:error]).to eq('Credentials are bad.')
  end
end
