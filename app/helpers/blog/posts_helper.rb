module Blog
  module PostsHelper
    
    def markdown(content = nil, &block)
      content = capture(&block) if block_given?
      Redcarpet.new(content).to_html.html_safe
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
    
    def this_blogger?(post)
      current_blogger == post.blogger
    end
    
  end
end
