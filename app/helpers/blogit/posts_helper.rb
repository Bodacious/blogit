module Blogit
  module PostsHelper
    
    def format_content(content = nil, &block)
      content = capture(&block) if block_given?
      Blogit::configuration.default_formatter.new(content).parsed.html_safe
    end
    
    def blog_post_tag(name, content_or_options = {}, options ={}, &block)
      if block_given?
        content = capture(&block)
        options = content_or_options
      else
        content = content_or_options
      end
      options[:class] = "#{options[:class]} blog_post_#{name}".strip
      content_tag(name, content, options)
    end
        
  end
end
