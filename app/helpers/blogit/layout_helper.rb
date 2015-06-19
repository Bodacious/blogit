module Blogit
  
  module LayoutHelper

    def title(content=nil)
      if content
        content_for(:title, content)
      else
        content_for(:title)
      end
    end
    
    
    def description(content=nil)
      if content
        content_for(:description, strip_tags(format_content(content)).html_safe)
      else
        content_for(:description)
      end
    end
    
  end
end