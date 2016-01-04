ActionMailer::Base.default_url_options = {
  :host => Rails.application.secrets.mailgun_host
}
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :address => Rails.application.secrets.mailgun_address,
  :domain => Rails.application.secrets.mailgun_domain,
  :port => Rails.application.secrets.mailgun_port,
  :user_name => Rails.application.secrets.mailgun_user_name,
  :password => Rails.application.secrets.mailgun_password,
  authentication: :plain
}
