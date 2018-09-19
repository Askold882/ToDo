class Api::ApplicationController < Api::ApiController
    def create
        user = User.new(user_params)
        if user.save
          UserMailer.send_confirmation_email(user).deliver_now
          render json: { message: 'user created, now confirm your email' }
        else
          render json: { tasks: @tasks }, status: 200
        end
      end
    
      def update
        user = User.find_by(confirm_token: params[:confirm_token])
        if user
          user.update(confirm_token: nil)
          render json: {}, status: 200
        else
          render json: { error: 'wrong token' }
        end
      end
    
      private
      
      def user_params
        params.require(:user).permit(:email, :password, :first_name, :last_name)
      end
    end