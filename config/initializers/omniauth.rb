OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '262325467304404', '9b99168917274f014915e1cbb9704e3b'
end
