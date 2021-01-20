# frozen_string_literal: true

module Api
  module V1
    class BackgroundsController < ApplicationController
      def show
        if params[:location]
          render json: BackgroundFacade.location_photos(params[:location])
        else
          render json: { message: 'unsuccessful', error: 'Location not found.' },
                 status: :bad_request
        end
      end
    end
  end
end
