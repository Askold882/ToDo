class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  
  private

  def curent_user
    @curent_user ||= User.find_by(user_token: cookies[:user_token])
  end

  def auth_user
    redirect_to new_session_path if !curent_user
  end
end
