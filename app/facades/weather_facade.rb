class WeatherFacade
  def self.get_forecast(lat, lon)
    forecast = WeatherService.find_forecast(lat, lon)
    Forecast.new(forecast)
  end
end