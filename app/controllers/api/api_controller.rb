class Api::ApiController < ApplicationController

  private

  def curent_user
    @curent_user ||= User.find_by(user_token: params[:user_token])
  end

  def auth_user
    render json: { errors: 'unauthorized!'}, status: 401 if !curent_user
  end
end