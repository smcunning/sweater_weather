# frozen_string_literal: true

module Api
  module V1
    class RoadTripController < ApplicationController
      def create
        road_trip_params = JSON.parse(request.body.string, symbolize_names: true)
        start_city = road_trip_params[:origin]
        end_city = road_trip_params[:destination]
        user = User.find_by(api_key: road_trip_params[:api_key])
        if user
          render json: RoadTripFacade.road_trip(start_city, end_city)
        else
          render json: { message: 'unsuccessful', error: 'API Key unauthorized' },
                 status: :unauthorized
        end
      end
    end
  end
end
