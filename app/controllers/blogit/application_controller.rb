module Blogit

  # Inherits from the application's controller instead of ActionController::Base
  class ApplicationController < ::ApplicationController

    helper Blogit::ApplicationHelper, Blogit::PostsHelper
    helper_method :current_blogger, :blogit_conf

    # Sets a class method to specify a before-filter calling
    # whatever Blogit.configuration.authentication_method is set to
    # Accepts the usual before_filter optionss
    def self.blogit_authenticate(options ={})
      before_filter blogit_conf.authentication_method, options
    end

    # A helper method to access the Blogit::configuration
    # at the class level
    def self.blogit_conf
      Blogit::configuration
    end

    # Turns on page caching for the given actions if
    # Blogit.configuration.cache_pages is true
    def self.blogit_cacher(*args)
      if blogit_conf.cache_pages
        caches_page *args
      end
    end

    # Sets a cache sweeper to observe changes if
    # Blogit.configuration.cache_pages is true
    def self.blogit_sweeper(*args)
      if blogit_conf.cache_pages
        cache_sweeper Blogit::BlogitSweeper, only: args
      end
    end

    # A helper method to access the Blogit::configuration
    # at the controller instance level
    def blogit_conf
      self.class.blogit_conf
    end

    # Returns the currently logged in blogger by calling
    # whatever Blogit.current_blogger_method is set to
    def current_blogger
      send blogit_conf.current_blogger_method
    end

    # Returns true if the current_blogger is the owner of the post
    # @param post An instance of Blogit::Post
    def this_blogger?(post)
      current_blogger == post.blogger
    end

  end
end