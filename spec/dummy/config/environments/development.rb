Dummy::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  if Rails.version =~ /\A3/
    # Log error messages when you accidentally call methods on nil.
    config.whiny_nils = true

    # Only use best-standards-support built into browsers
    config.action_dispatch.best_standards_support = :builtin

    # Do not compress assets
    config.assets.compress = false
  end

  if Rails.version =~ /\A4/
    config.eager_load = false

    # Raise an error on page load if there are pending migrations
    config.active_record.migration_error = :page_load
  end

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Expands the lines which load the assets
  config.assets.debug = true
end
