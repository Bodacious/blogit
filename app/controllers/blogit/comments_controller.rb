module Blogit
  class CommentsController < ApplicationController

    blogit_authenticate except: [:create]

    def create
      @comment = post.comments.new(comment_parameters)
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

    private

    def post
      @post ||= Blogit::Post.find(params[:post_id])
    end
    
    def comment_parameters
      params.require(:comment).permit(:name, :email, :body, :website)
    end
    
  end
end
