# frozen_string_literal: true

require 'rails_helper'

describe BackgroundFacade do
  describe 'class methods' do
    it '.location_photos' do
      VCR.use_cassette('denver-photos') do
        image_data = BackgroundFacade.location_photos('denver,co')

        expect(image_data).to be_an_instance_of(BackgroundSerializer)
      end
    end
  end
end
