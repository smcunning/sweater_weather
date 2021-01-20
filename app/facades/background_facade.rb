# frozen_string_literal: true

class BackgroundFacade
  def self.location_photos(location)
    photo_data = UnsplashService.location_photos(location)

    if photo_data[:results][0]
      background = Background.new(photo_data)
      BackgroundSerializer.new(background)
    else
      { message: 'unsuccessful', error: 'Location not found.' }
    end
  end
end
