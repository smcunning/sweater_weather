# frozen_string_literal: true

module Api
  module V1
    class SessionsController < ApplicationController
      def create
        login_creds = JSON.parse(request.body.string, symbolize_names: true)
        user = User.find_by(email: login_creds[:email])
        if user&.authenticate(login_creds[:password])
          render json: UserSerializer.new(user), status: :ok
        else
          render json: { message: 'unsuccessful', error: 'Credentials are bad.' },
                 status: :unauthorized
        end
      end
    end
  end
end
