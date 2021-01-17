# frozen_string_literal: true

module Api
  module V1
    class ForecastController < ApplicationController
      def show
        render json: ForecastFacade.forecast(params[:location])
      end
    end
  end
end
