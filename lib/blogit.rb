# Third-party requirements
require "acts-as-taggable-on"
require "kaminari"
require "redcarpet"
require "pingr"

require "blogit/configuration"
require "blogit/blogs"
require "blogit/engine"
require "blogit/parsers"

require "validators"
module Blogit
  
  autoload :ActsAsTaggableOn, "acts-as-taggable-on"
  autoload :Kaminari, "kaminari"
  
  # Exception raised when gem may not be configured properly
  class ConfigurationError < StandardError;end
  
  # Set global configuration options for Blogit
  # @see README.md
  def self.configure(&block)
    block.call(configuration)
  end
  
  # Returns Blogit's globalconfiguration. Will initialize a new instance
  # if not already set
  def self.configuration
    @configuration ||= Configuration.new
  end

end
