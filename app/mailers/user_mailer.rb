class UserMailer < ApplicationMailer
  def new_password(identity, password)
    @password = password
    @url = "https://fitbird.us"
    mail to: identity.email, subject: "New password"
  end
end
