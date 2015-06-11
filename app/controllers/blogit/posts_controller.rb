module Blogit

  class PostsController < ::Blogit::ApplicationController

    attr_reader :post
    
    attr_reader :posts
    
    # If a layout is specified, use that. Otherwise, fall back to the default
    layout Blogit.configuration.layout if Blogit.configuration.layout


    def index
      respond_to do |format|
        format.xml  { set_posts_for_feed }
        format.rss  { set_posts_for_feed }
        format.html { set_posts_for_index_page }
      end
    end

    def show
      set_post
    end

    def tagged
      set_posts_for_tagged_page
      render :index
    end


    private
    
    
    def set_post
      @post = Post.find(params[:id])
    end
    

    def page_number
      @page_number ||= params[Kaminari.config.param_name]
    end
    
    def set_posts_for_feed
      @posts ||= Post.for_feed
    end
    
    def set_posts_for_index_page(tag = nil)
      @posts ||= Post.active.for_index(page_number)
    end
    
    def set_posts_for_tagged_page
      @posts = set_posts_for_index_page.tagged_with(params[:tag])
    end

  end

end