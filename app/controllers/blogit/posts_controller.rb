module Blogit

  # Handles requests for viewing Blogit::Posts
  class PostsController < ::Blogit::ApplicationController

    # The current Blogit::Post being displayed.
    #
    # Returns a Blogit::Post with id from params
    attr_reader :post

    # The current Posts being displayed
    #
    # Returns ActiveRecord::Relation for Post table
    attr_reader :posts
    
    # If a layout is specified, use that. Otherwise, fall back to the default
    layout Blogit.configuration.layout if Blogit.configuration.layout

    # Handles GET requests to /blogit/posts.html, /blogit/posts.xml, and /blogit/posts.rss
    # Possible formats include:
    #
    # "XML" -  calls {#set_posts_for_feed}.
    # "RSS" -  calls {#set_posts_for_feed}.
    # "HTML" - calls {#set_posts_for_index_page}.
    #
    # Returns nil
    def index
      respond_to do |format|
        format.xml  { set_posts_for_feed }
        format.rss  { set_posts_for_feed }
        format.html { set_posts_for_index_page }
      end
    end

    # Handles GET requests to /blogit/posts/:id.html
    def show
      set_post
    end

    # Handles GET requests to /blogit/posts/tagged/:tag.html. Renders the index template
    # with Posts tagged with tag in *tag* parameter
    def tagged
      set_posts_for_tagged_page
      render :index
    end


    private
    
    
    # Set {#post} based on the :id param
    def set_post
      @post = Post.active_with_id(params[:id])
    end
    
    # The page parameter value for the current locale
    def page_number
      @page_number ||= params[Kaminari.config.param_name]
    end
    
    # Sets {#posts} for the XML feed
    def set_posts_for_feed
      @posts ||= Post.for_feed
    end

    # Sets {#posts} for the HTML index page
    # 
    # tag - The tag name to filter Posts by (default: nil)
    #
    def set_posts_for_index_page(tag = nil)
      @posts ||= Post.for_index(page_number)
    end
    
    def set_posts_for_tagged_page
      @posts = set_posts_for_index_page.tagged_with(params[:tag])
    end

  end

end