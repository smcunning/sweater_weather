# frozen_string_literal: true

module Api
  module V1
    class MunchiesController < ApplicationController
      def show
        start_city = params[:start]
        end_city = params[:end]
        category = params[:category]
        render json: MunchiesFacade.munchies_at_destination(start_city, end_city, category)
      end
    end
  end
end
