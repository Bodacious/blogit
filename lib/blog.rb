require "blog/configuration"
require "blog/blogs"
require "blog/engine"
require "validators"

module Blog
  
  # Exception raised when gem may not be configured properly
  class ConfigurationError < StandardError;end
  
  def self.configure(&block)
    block.call(configuration)
  end
  
  def self.configuration
    @configuration ||= Configuration.new
  end

end
