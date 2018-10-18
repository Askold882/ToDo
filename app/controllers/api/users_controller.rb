class Api::UsersController < Api::ApiController
  def create
    user = User.new(user_params)
    if user.save
      UserMailer.send_confirmation_email(user, params[:back_url]).deliver_now
      render json: { message: 'user created, now confirm your email' }, status: 200
    else
      render json: { error: user.errors.full_messages.to_sentence }, status: 403
    end
  end
    
  def update
    user = User.find_by(confirm_token: params[:confirm_token])
    if user
      user.update(confirm_token: nil) 
      if params[:back_url]
        redirect_to params[:back_url]
      else
        render json: {}, status: 200
      end
    else
      render json: { error: 'wrong token' }, status:401
    end
  end

  private
  
  def user_params
    params.require(:user).permit(:email, :password, :first_name, :last_name)
  end
end