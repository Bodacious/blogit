module Blogit
  class PostsController < ApplicationController

    if blogit_conf.include_admin_actions
      before_filter :raise_404, except: [:index, :show]
    end

    blogit_authenticate(except: [:index, :show])

    expose(:posts) { Post.for_index(params[:page]) }
    expose(:post) do
      case action_name
      when /new|create/
        current_blogger.blog_posts.new(params[:post])
      when /edit|update|destroy/
        current_blogger.blog_posts.find(params[:id])
      when /show/
        Blogit::Post.find(params[:id])
      end
    end

    expose(:comments) { post.comments }
    expose(:comment) { post.comments.build }

    def index
    end

    def show
    end


    def new
    end

    def edit
    end

    def create
      if post.save
        redirect_to post, notice: 'Blog post was successfully created.'
      else
        render action: "new"
      end
    end

    def update
      if post.update_attributes(params[:post])
        redirect_to post, notice: 'Blog post was successfully updated.'
      else
        render action: "edit"
      end
    end

    def destroy
      post.destroy
      redirect_to posts_url, notice: "Blog post was successfully destroyed."
    end

    private

    def raise_404
      # Don't include admin actions if include_admin_actions is false
      render file: "#{Rails.root}/public/404.html", status: :not_found, layout: false
    end
    
  end

end