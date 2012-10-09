module Blogit

  class PostsController < ApplicationController

    unless blogit_conf.include_admin_actions
      before_filter :raise_404, except: [:index, :show, :tagged]
    end

    blogit_authenticate(except: [:index, :show, :tagged])

    blogit_cacher(:index, :show, :tagged)
    blogit_sweeper(:create, :update, :destroy)

    def index
      respond_to do |format|
        format.xml {
          @posts = Post.order('created_at DESC')
        }
        format.html {
          @posts = Post.for_index(params[:page])
        }
        format.rss {
          @posts = Post.order('created_at DESC')
        }
      end
    end

    def show
      @post = Post.find(params[:id])
    end

    def tagged
      @posts = Post.for_index(params[:page]).tagged_with(params[:tag])
      render :index
    end

    def new
      @post = current_blogger.blog_posts.new(params[:post])
    end

    def edit
      @post = current_blogger.blog_posts.find(params[:id])
    end

    def create
      @post = current_blogger.blog_posts.new(params[:post])
      if @post.save
        redirect_to @post, notice: t(:blog_post_was_successfully_created, scope: 'blogit.posts')
      else
        render action: "new"
      end
    end

    def update
      @post = current_blogger.blog_posts.find(params[:id])
      if @post.update_attributes(params[:post])
        redirect_to @post, notice: t(:blog_post_was_successfully_updated, scope: 'blogit.posts')
      else
        render action: "edit"
      end
    end

    def destroy
      @post = current_blogger.blog_posts.find(params[:id])
      @post.destroy
      redirect_to posts_url, notice: t(:blog_post_was_successfully_destroyed, scope: 'blogit.posts')
    end

    private

    def raise_404
      # Don't include admin actions if include_admin_actions is false
      render file: "#{Rails.root}/public/404.html", status: :not_found, layout: false
    end

  end

end
