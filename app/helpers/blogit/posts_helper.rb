module Blogit
  module PostsHelper
    
    # Format content using the {Blogit::Configuration#default_parser_class default_parser_class}
    def format_content(content = nil, &block)
      content = capture(&block) if block_given?
      parser = Blogit::configuration.default_parser_class.new(content)
      parser.parsed.html_safe
    end
    
    # Creates a div tag with class 'blog_post_' + name
    # Eg: 
    #   blog_post_tag(:title, "") # => <div class="blog_post_title"></div>
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
