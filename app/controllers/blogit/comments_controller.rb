module Blogit
  class CommentsController < ApplicationController

    attr_reader :comment
    
    attr_reader :post
    
    def create
      set_post_from_post_id
      set_comment_as_new
      respond_to do |format|
        comment.save
        format.js { create_respond_to_js }
        format.html { create_respond_to_html }
      end
    end


    private


    def set_post_from_post_id
      @post = Blogit::Post.find(params[:post_id])
    end
    
    def set_comment_as_new
      @comment = post.comments.new(comment_params)
    end
    
    def create_respond_to_js
      render status: (comment.persisted? ? :created : :bad_request)
    end
    
    def create_respond_to_html
      if comment.persisted?
        redirect_to(post, notice: t(:successfully_added_comment, scope: 'blogit.comments'))
      else
        render "blogit/posts/show"
      end  
    end
    
    def comment_params
      params.require(:comment).permit(:name, :nickname, :email, :body, :website)
    end
    
  end
  
end