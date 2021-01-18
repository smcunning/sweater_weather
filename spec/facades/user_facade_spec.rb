# frozen_string_literal: true

require 'rails_helper'

describe UserFacade do
  describe 'class methods' do
    it '.create_user' do
      user_params =  "{\"email\":\"example@example.com\",\"password\":\"password\",\"password_confirmation\":\"password\"}"

      user_response = UserFacade.create_user(user_params)

      expect(user_response).to be_an_instance_of(UserSerializer)
    end
  end
end
