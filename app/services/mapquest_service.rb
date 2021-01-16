class MapquestService
  def self.coordinates_by_city(city)
    results = conn.get('/geocoding/v1/address?') do |req|
      req.params[:key] = ENV['MAPQUEST_API_KEY']
      req.params[:location] = city
    end
    parse(results)
  end

  def self.conn
    Faraday.new(url: 'http://www.mapquestapi.com')
  end

  def self.parse(results)
    JSON.parse(results.body, symbolize_names: true)
  end
end
