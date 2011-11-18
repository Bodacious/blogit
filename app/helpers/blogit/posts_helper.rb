module Blogit
  module PostsHelper
        
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
