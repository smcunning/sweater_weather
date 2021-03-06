# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { 'MyString' }
    password_digest { 'MyString' }
    api_key { 'MyString' }
  end
end
