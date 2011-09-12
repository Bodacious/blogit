module Blog

  # Inherits from the application's controller instead of ActionController::Base
  class ApplicationController < ::ApplicationController
    
    helper :all
    helper_method :current_blogger
    
    def current_blogger
      send Blog::configuration.current_blogger_method
    end
    
    def this_blogger?(post)
      current_blogger == post.blogger
    end
    
  end
end
