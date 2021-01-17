# frozen_string_literal: true

module Api
  module V1
    class BackgroundsController < ApplicationController
      def show
        render json: BackgroundFacade.location_photos(params[:location])
      end
    end
  end
end
