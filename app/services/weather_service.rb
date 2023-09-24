class WeatherService
  def self.find_forecast(lat, lon)
    response = conn.get do |f|
      f.params["key"] = Rails.application.credentials.weather[:access_key]
      f.params["q"] = "#{lat},#{lon}"
      f.params["days"] = 5
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    url = "http://api.weatherapi.com/v1/forecast.json"
    Faraday.new(url: url)
  end
end