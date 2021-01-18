# frozen_string_literal: true

require 'rails_helper'

describe 'User Registration Endpoint' do
  before(:each) do
    User.destroy_all
  end
  it 'can create a user with a unique API key' do
    user_params = {
      email: 'example@example.com',
      password: 'password',
      password_confirmation: 'password'
    }

    headers = { 'CONTENT_TYPE' => 'application/json' }

    post '/api/v1/users', headers: headers, params: user_params, as: :json
    created_user = User.last

    expect(response).to be_successful
    expect(response.status).to eq(201)
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

  it 'cannot register a new user if passwords dont match' do
    user_params = {
      email: 'example@example.com',
      password: 'password',
      password_confirmation: 'password1'
    }

    headers = { 'CONTENT_TYPE' => 'application/json' }

    post '/api/v1/users', headers: headers, params: user_params, as: :json

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json[:message]).to eq('unsuccessful')
    expect(json[:error]).to eq("Password confirmation doesn't match Password")
  end

  it 'cannot register a new user if field left blank' do
    user_params = {
      email: '',
      password: 'password',
      password_confirmation: 'password'
    }

    headers = { 'CONTENT_TYPE' => 'application/json' }

    post '/api/v1/users', headers: headers, params: user_params, as: :json

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json[:message]).to eq('unsuccessful')
    expect(json[:error]).to eq("Email can't be blank")
  end

  it 'cannot register a new user if email already exists' do
    user_params = {
      email: 'example@example.com',
      password: 'password',
      password_confirmation: 'password'
    }

    headers = { 'CONTENT_TYPE' => 'application/json' }

    post '/api/v1/users', headers: headers, params: user_params, as: :json

    # second post to attempt to create duplicate user
    post '/api/v1/users', headers: headers, params: user_params, as: :json

    json = JSON.parse(response.body, symbolize_names: true)
    expect(json[:message]).to eq('unsuccessful')
    expect(json[:error]).to eq('Email has already been taken')
  end
end
