class Api::V0::ForecastController < ApplicationController

  def index
    begin
      lat_lon = MapquestFacade.get_lat_lon(params[:location])
      forecast = WeatherFacade.get_forecast(lat_lon[:lat], lat_lon[:lng])
      render json: ForecastSerializer.new(forecast), status: :ok
    rescue StandardError => e
      render json: ErrorSerializer.error_handler(e), status: 404
    end
  end
end