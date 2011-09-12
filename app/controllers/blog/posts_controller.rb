module Blog
  class PostsController < ApplicationController
    
    before_filter Blog.configuration.authentication_method, except: [:index, :show]
    
    expose(:posts) { Post.for_index(params[:page]) }
    expose(:post) do
      case action_name
      when /new|create/
        current_blogger.blog_posts.new(params[:post])
      when /edit|update|destroy/
        current_blogger.blog_posts.find(params[:id])
      when /show/
        Blog::Post.find(params[:id])
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
      redirect_to posts_url
    end
    
  end
end