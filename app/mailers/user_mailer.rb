class UserMailer < ApplicationMailer
  def password_reset(user)
    @url = "https://api.fitbird.us/api/password_resets/"+user.password_reset_token
    mail to: user.email, subject: "Password Reset"
  end
end
