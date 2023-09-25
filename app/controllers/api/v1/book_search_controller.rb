class Api::V1::BookSearchController < ApplicationController
  def index
    begin
      require 'pry'; binding.pry
      lat_lon = MapquestFacade.get_lat_lon(params[:location])
      forecast = WeatherFacade.get_forecast(lat_lon[:lat], lat_lon[:lng])
      books_by_location = LibraryFacade.get_books(params[:location], params[:quantity], forecast)
      require 'pry'; binding.pry
      render json: ForecastSerializer.new(forecast), status: :ok
    rescue StandardError => e
      render json: ErrorSerializer.error_handler(e), status: 404
    end
  end
end