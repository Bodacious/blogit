require "blogit/version"
require "blogit/engine"

require "blogit/configuration"
require "blogit/blogs"
require "blogit/parsers"

require "validators"

module Blogit
  # Exception raised when gem may not be configured properly
  class ConfigurationError < StandardError; end

  # Set global configuration options for Blogit. {file:README.md read more}
  def self.configure(&block)
    yield(configuration)
  end

  # Blogit's global configuration.
  #
  # Returns a Configuration
  def self.configuration
    @configuration ||= Configuration.new
  end
end
