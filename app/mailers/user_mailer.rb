class UserMailer < ApplicationMailer
  def send_confirmation_email(user, back_url = nil)
    @user = user 
    @back_url = back_url || '' 
    mail to:  @user.email, subject: 'Thanks for signing up for ...' 
  end
end