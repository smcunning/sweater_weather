# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      def create
        render json: UserFacade.create_user(request.body.string), status: :created
      end
    end
  end
end
