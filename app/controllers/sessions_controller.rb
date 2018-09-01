class SessionsController < ApplicationController
  def new
  end

  def create
    p(params[:email])
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      if user.confirm_token == nil
        cookies[:user_token] = user.user_token
        redirect_to tasks_path
      else
        render json: {error: 'email unconfirmed'}
      end
    else
      render json: {error: 'wrong data'}
    end
  end
end
