# Store images on AWS S3.
Paperclip::Attachment.default_options.merge!(
  :default_url => "http://:s3_domain/:rails_env/:class/default/:attachment/:style.:extension",
  :path => ":rails_env/:class/:id/:attachment/:style/:basename.:extension",
  :url => ":s3_domain_url",
  :storage => :s3,
  :s3_credentials => {
    :bucket => Rails.application.secrets.s3_bucket,
    :access_key_id => Rails.application.secrets.s3_key,
    :secret_access_key => Rails.application.secrets.s3_secret
  }
)

Paperclip.interpolates(:s3_domain) do |attachment, style|
  [Paperclip::Attachment.default_options[:s3_credentials][:bucket], ".s3.amazonaws.com"].join
end

# Set image size with ImageMagick.
Paperclip.options[:command_path] = "/opt/local/bin/convert"
