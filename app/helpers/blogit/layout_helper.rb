module Blogit
  
  module LayoutHelper

    # Sets or returns the title for a page
    #
    # content - The content to include in the HTML title tag.
    #
    # Returns a String
    def title(content=nil)
      if content
        content_for(:title, content)
      else
        content_for(:title)
      end
    end
    
    # Sets or returns the description for a page. Formats the content if it's Markdown or
    # HTML and strips out the HTML tags.
    #
    # content - The content to include in the HTML meta description tag.
    #
    # Returns a String    
    def description(content=nil)
      if content
        content_for(:description, strip_tags(format_content(content)).html_safe)
      else
        content_for(:description)
      end
    end
    
  end
end