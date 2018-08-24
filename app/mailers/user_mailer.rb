class UserMailer < ApplicationMailer
    def send_confirmation_email(user)
      @user = user
      mail to:  @user.email, subject: 'Thanks for signing up for ...' 
    end
end