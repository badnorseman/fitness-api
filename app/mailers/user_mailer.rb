class UserMailer < ApplicationMailer
  def new_password(identity)
    # @url = "https://fitbird.us
    @url = "http://localhost:8080"
    mail to: identity.email, subject: "New password"
  end
end
