module Blogit
  class CommentsController < ApplicationController

    blogit_authenticate except: [:create]

    blogit_sweeper(:create, :update, :destroy)


    def create
      @comment = post.comments.new(valid_params)
      respond_to do |format|
        format.js {
          # the rest is dealt with in the view
          @comment.save
        }

        format.html {
          if @comment.save
            redirect_to(post, notice: t(:successfully_added_comment, scope: 'blogit.comments'))
          else
            render "blogit/posts/show"
          end
        }

      end

    end

    def destroy
      @comment = post.comments.find(params[:id])
      @comment.destroy
      respond_to do |format|
        format.html { redirect_to(post, notice: t(:successfully_removed_comment, scope: 'blogit.comments'))}
        format.js
      end
    end

    protected

    def valid_params
      params.require(:comment).permit(:name, :nickname, :email, :body, :website)
    end

    private

    def post
      @post ||= Blogit::Post.find(params[:post_id])
    end

  end
end
