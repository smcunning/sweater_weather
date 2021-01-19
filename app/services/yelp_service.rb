# frozen_string_literal: true

class YelpService
  def self.businesses(location, open_at, category)
    results = conn.get('/v3/businesses/search?') do |req|
      req.headers["Authorization"] = "Bearer #{ENV.fetch("YELP_API_KEY")}"
      req.params[:location] = location
      req.params[:open_at] = open_at
      req.params[:category] = category
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
