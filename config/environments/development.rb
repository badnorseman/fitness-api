Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you do not have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Do care if the mailer can not send.
  config.action_mailer.raise_delivery_errors = true

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Generate digests for assets URLs.
  config.assets.digest = true

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Add additional error checking when serving assets at runtime.
  # Check for improperly declared sprockets dependencies.
  # Raise helpful error messages.
  config.assets.raise_runtime_errors = true

  # Raise error for missing translations.
  # config.action_view.raise_on_missing_translations = true

  # Store images on AWS S3 with Paperclip
  config.paperclip_defaults = {
    :path => ":attachment/:class/:id/:style/:basename.:extension",
    :url => ":s3_domain_url",
    :storage => :s3,
    :s3_credentials => {
      :bucket => Rails.application.secrets.s3_bucket,
      :access_key_id => Rails.application.secrets.s3_key,
      :secret_access_key => Rails.application.secrets.s3_secret
    }
  }

  # Accept online payment with Braintree.
  Braintree::Configuration.environment = :sandbox
  Braintree::Configuration.merchant_id = Rails.application.secrets.braintree_merchant_id
  Braintree::Configuration.private_key = Rails.application.secrets.braintree_private_key
  Braintree::Configuration.public_key = Rails.application.secrets.braintree_public_key
end
