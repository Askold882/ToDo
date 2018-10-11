class Api::SessionsController < Api::ApiController
    def index
      user = User.find_by(user_token: params[:user_token])
      if user
        render json: {}, status: 200
      else
        render json: {}, status: 401
      end
    end
   
    def create
      user = User.find_by(email: params[:email])
      if user && user.authenticate(params[:password])
        if user.confirm_token == nil
          render json: {token: user.user_token}, status: 200
        else
          render json: {error: 'email unconfirmed'}, status: 401
        end
      else
        render json: {error: 'wrong data'}, status: 401
      end
    end
  
    def destroy
      curent_user.regenerate_user_token if curent_user
      render json: {}, status: 200
    end
  end
  