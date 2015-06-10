module Blogit

  class PostsController < ::Blogit::ApplicationController

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
      @post = Post.find(params[:id])
    end

    def tagged
      @posts = set_posts_for_index_page(params[:tag])
      render :index
    end


    private
    

    def page_number
      @page_number ||= params[Kaminari.config.param_name]
    end
    
    def raise_404
      # Don't include admin actions if include_admin_actions is false
      render file: "#{Rails.root}/public/404.html", status: :not_found, layout: false
    end
    
    def set_posts_for_feed
      @posts ||= Post.active.order('created_at DESC')   
    end
    
    def set_posts_for_index_page(tag = nil)
      @posts = Post.active.for_index(page_number)
      @posts = @posts.tagged_with(tag) if tag
      return @posts
    end

  end

end