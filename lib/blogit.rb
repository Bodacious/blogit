require "blogit/configuration"
require "blogit/blogs"
require "blogit/engine"

require "blogit/formatters/html_formatter"
require "blogit/formatters/markdown_formatter"
require "blogit/formatters/textile_formatter"

require "validators"

module Blogit
  
  # Exception raised when gem may not be configured properly
  class ConfigurationError < StandardError;end
  
  def self.configure(&block)
    block.call(configuration)
  end
  
  def self.configuration
    @configuration ||= Configuration.new
  end

end
