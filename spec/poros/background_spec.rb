# frozen_string_literal: true

require 'rails_helper'

describe Background do
  it 'exists with attributes' do
    VCR.use_cassette('denver-photos') do
      photo_data = UnsplashService.location_photos('denver,co')
      background = Background.new(photo_data)

      expect(background.id).to eq('null')
      expect(background.image).to be_an_instance_of Image
      expect(background.credit).to be_an_instance_of Credit
    end
  end
end
