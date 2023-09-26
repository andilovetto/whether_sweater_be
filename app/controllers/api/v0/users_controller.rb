class Api::V0::UsersController < ApplicationController
  def create
    begin
      user = User.create!(user_params)
      render json: UserSerializer.new(user), status: 201
    rescue StandardError => e
      render json: ErrorSerializer.error_handler(e), status: 400
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation, :api_key)
  end
end