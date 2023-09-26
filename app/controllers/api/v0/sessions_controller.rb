class Api::V0::SessionsController < ApplicationController
# rescue_from ActiveRecord::RecordNotFound, with: :bad_credentials
# rescue_from ActiveRecord::RecordInvalid, with: :bad_credentials
  
  def create
    begin
      user = User.find_by!(email: params[:email])
      if user.authenticate(params[:password])
        session[:user_id] = user.id
        render json: UserSerializer.new(user), status: 200
      else 
        bad_credentials
      end
    rescue StandardError
      bad_credentials
    end

  end

  private

  def bad_credentials
    render json: { error: "bad credentials" }, status: 400
  end
end