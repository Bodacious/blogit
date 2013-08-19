Dummy::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # Code is not reloaded between requests
  config.cache_classes = true
  
  if Rails.version.first == "4"
    # Eager load code on boot. This eager loads most of Rails and
    # your application in memory, allowing both thread web servers
    # and those relying on copy on write to perform better.
    # Rake tasks automatically ignore this option for performance.
    config.eager_load = true
    
    # Enable Rack::Cache to put a simple HTTP cache in front of your application
    # Add `rack-cache` to your Gemfile before enabling this.
    # For large-scale production use, consider using a caching reverse proxy like nginx, varnish or squid.
    # config.action_dispatch.rack_cache = true
  end

  # Full error reports are disabled and caching is turned on
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  if Rails.version.first == '4'
    # Compress JavaScripts and CSS.
    config.assets.js_compressor = :uglifier
    # config.assets.css_compressor = :sass
    
    # Generate digests for assets URLs.
    config.assets.digest = true

    # Version of your assets, change this if you want to expire all your assets.
    config.assets.version = '1.0'

    # Use default logging formatter so that PID and timestamp are not suppressed.
    config.log_formatter = ::Logger::Formatter.new    
  else
    # Compress JavaScripts and CSS
    config.assets.compress = true    
  end

  # Disable Rails's static asset server (Apache or nginx will already do this)
  config.serve_static_assets = false


  # Specifies the header that your server uses for sending files
  # (comment out if your front-end server doesn't support this)
  config.action_dispatch.x_sendfile_header = "X-Sendfile" # Use 'X-Accel-Redirect' for nginx

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found)
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners
  config.active_support.deprecation = :notify
end
