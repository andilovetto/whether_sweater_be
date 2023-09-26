class Api::V0::RoadTripController < ApplicationController
  def create
    user = User.find_by(api_key: params[:api_key])
    if user
      road_trip = RoadTripFacade.get_road_trip(params[:origin], params[:destination])
      render json: RoadTripSerializer.new(road_trip), status: :ok
    else
      bad_credentials
    end
  end
  private

  def bad_credentials
    render json: { error: "bad credentials" }, status: 401
  end
end 

