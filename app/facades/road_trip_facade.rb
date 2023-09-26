class RoadTripFacade
  def self.get_road_trip(origin, destination)
    directions = MapquestService.find_directions(origin, destination)
    lat_lon = MapquestFacade.get_lat_lon(destination)
    forecast = WeatherFacade.get_forecast(lat_lon[:lat], lat_lon[:lng])
    RoadTrip.new(origin, destination, directions, forecast)
  end
end