# Store images on AWS S3
Paperclip::Attachment.default_options.merge!(
  :path => ":attachment/:class/:id/:style/:basename.:extension",
  :url => ":s3_domain_url",
  :storage => :s3,
  :s3_credentials => {
    :bucket => Rails.application.secrets.s3_bucket,
    :access_key_id => Rails.application.secrets.s3_key,
    :secret_access_key => Rails.application.secrets.s3_secret
  }
)
