class Api::V1::BookSearchController < ApplicationController
  def index
    begin
      lat_lon = MapquestFacade.get_lat_lon(params[:location])
      forecast = WeatherFacade.get_forecast(lat_lon[:lat], lat_lon[:lng])
      books_by_location = LibraryFacade.get_books(params[:location], params[:quantity], forecast)
      render json: BookSerializer.new(books_by_location), status: :ok
    rescue StandardError => e
      render json: ErrorSerializer.error_handler(e), status: 404
    end
  end
end