module Blogit
  
  module LayoutHelper
    
    
    def description(content=nil)
      if content
        content_for(:description, content)
      else
        content_for(:description)
      end
    end
    
  end
end