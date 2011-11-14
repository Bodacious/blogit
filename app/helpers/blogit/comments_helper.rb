module Blogit
  module CommentsHelper
    
    # Creates a div tag with class 'blog_comment_' + name
    # Eg: 
    #   blog_comment_tag(:email, "") # => <div class="blog_comment_email"></div>
    def blog_comment_tag(name, content_or_options = {}, options ={}, &block)
      if block_given?
        content = capture(&block)
        options = content_or_options
      else
        content = content_or_options
      end
      options[:class] = "#{options[:class]} blog_comment_#{name}".strip
      content_tag(name, content, options)
    end

  end
end
