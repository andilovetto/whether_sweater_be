class MapquestService

  def self.find_lat_lon(location)
    response = conn('geocoding/v1/address').get do |f|
      f.params["key"] = Rails.application.credentials.mapquest[:access_key]
      f.params["location"] = location
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.find_directions(origin, destination)
    response = conn('directions/v2/route').get do |f|
      f.params["key"] = Rails.application.credentials.mapquest[:access_key]
      f.params["from"] = origin
      f.params["to"] = destination
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn(endpoint_url)
    url = "https://www.mapquestapi.com/#{endpoint_url}"
    Faraday.new(url: url)
  end
end