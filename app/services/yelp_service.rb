# frozen_string_literal: true

class YelpService
  def self.businesses(location)
    results = conn.get('/v3/businesses/search?') do |req|
      req.headers["Authorization"] = "Bearer #{ENV.fetch("YELP_API_KEY")}"
      req.params[:location] = location
    end
    parse(results)
  end

  def self.conn
    Faraday.new(url: 'https://api.yelp.com/')
  end

  def self.parse(results)
    JSON.parse(results.body, symbolize_names: true)
  end
end
