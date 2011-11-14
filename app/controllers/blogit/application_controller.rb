module Blogit

  # Inherits from the application's controller instead of ActionController::Base
  class ApplicationController < ::ApplicationController
    
    helper :all
    helper_method :current_blogger, :blogit_conf
    
    def self.blogit_authenticate(options ={})
      before_filter blogit_conf.authentication_method, options
    end
    
    def self.blogit_conf
      Blogit::configuration
    end
    
    def blogit_conf
      self.class.blogit_conf
    end
    
    def current_blogger
      send blogit_conf.current_blogger_method
    end
    
    def this_blogger?(post)
      current_blogger == post.blogger
    end
    
  end
end
