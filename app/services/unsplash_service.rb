# frozen_string_literal: true

class UnsplashService
  def self.location_photos(location)
    results = conn.get('/search/photos?') do |req|
      req.params[:client_id] = ENV['UNSPLASH_API_KEY']
      req.params[:query] = location
      req.params[:content_filter] = 'high'
      req.params[:orientation] = 'landscape'
    end
    parse(results)
  end

  def self.conn
    Faraday.new(url: 'https://api.unsplash.com/')
  end

  def self.parse(results)
    JSON.parse(results.body, symbolize_names: true)
  end
end
