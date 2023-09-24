class MapquestService

  def self.find_lat_lon(location)
    response = conn.get do |f|
      f.params["key"] = Rails.application.credentials.mapquest[:access_key]
      f.params["location"] = location
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    url = "https://www.mapquestapi.com/geocoding/v1/address"
    Faraday.new(url: url)
  end



end