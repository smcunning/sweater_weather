# frozen_string_literal: true

class BackgroundFacade
  def self.location_photos(location)
    photo_data = UnsplashService.location_photos(location)
    background = Background.new(photo_data)
    BackgroundSerializer.new(background)
  end
end
