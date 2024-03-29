Ndd::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  #Mail catcher
  config.action_mailer.delivery_method = :smtp #:letter_opener - alternative
  config.action_mailer.smtp_settings = { :address => "localhost", :port => 1025 } #Mail Catcher
  # Care if the mailer can't send
  config.action_mailer.raise_delivery_errors = true
  
  

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Do not compress assets
  config.assets.compress = false

  # Expands the lines which load the assets
  config.assets.debug = true
  
  
 # DEFAULT_HOST = "localhost"
  #DEFAULT_HOST_WITH_PORT = "www.#{DEFAULT_HOST}"
 # DEFAULT_ROOT_URI = "http://#{DEFAULT_HOST_WITH_PORT}"
  
 # config.action_mailer.default_url_options = { :host => DEFAULT_HOST_WITH_PORT } # change this
  
end
