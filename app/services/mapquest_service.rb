# frozen_string_literal: true

class MapquestService
  def self.coordinates_by_city(city)
    results = conn.get('/geocoding/v1/address?') do |req|
      req.params[:key] = ENV['MAPQUEST_API_KEY']
      req.params[:location] = city
    end
    parse(results)
  end

  def self.directions(start_city, end_city)
    results = conn.get('/directions/v2/route?') do |req|
      req.params[:key] = ENV['MAPQUEST_API_KEY']
      req.params[:from] = start_city
      req.params[:to] = end_city
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
