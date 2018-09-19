class Api::SessionsController < Api::ApiController
    def create
      render json: {}, status: 200
      user = User.find_by(email: params[:email])
      if user && user.authenticate(params[:password])
        if user.confirm_token == nil
          render json: {token: user.user_token}
        else
          render json: {error: 'email unconfirmed'}, status: 401
        end
      else
        render json: {error: 'wrong data'}, status: 401
      end
    end
  
    def destroy
      curent_user.regenerate_user_token
      render json: {}, status: 200
    end
  end
  