# frozen_string_literal: true

module Api
  module V1
    class ForecastController < ApplicationController
      def show
        if params[:location]
          render json: ForecastFacade.forecast(params[:location])
        else
          render json: { message: 'unsuccessful', error: 'Location not found.' },
                 status: 400
        end
      end
    end
  end
end
