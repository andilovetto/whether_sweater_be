class MapquestFacade
  def self.get_lat_lon(location)
    lat_lon = MapquestService.find_lat_lon(location)
    lat_lon[:results][0][:locations][0][:latLng]
  end
end