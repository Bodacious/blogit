module Blogit
  
  # Handles requests for creating Blogit::Comments 
  class CommentsController < ApplicationController

    # Accessor method for the comment being created
    #
    # Returns a Blogit::Comment
    attr_reader :comment
    
    # Accessor method for the Post we're adding a Comment to
    #
    # Returns Post
    attr_reader :post
    
    # Handles POST requests to /blogit/comments.html and /blogit/comments.js
    def create
      set_post_from_post_id
      set_comment_as_new
      comment.save
      respond_to do |format|
        format.js   { create_respond_to_js }
        format.html { create_respond_to_html }
      end
    end


    private


    # Set this controller's post attribute to the current Post
    def set_post_from_post_id
      @post = Blogit::Post.find(params[:post_id])
    end

    # Set this controller's comment attribute as a new comment with params
    def set_comment_as_new
      @comment = post.comments.new(comment_params)
    end

    # The create action render call when format is JS
    def create_respond_to_js
      render status: (comment.persisted? ? :created : :bad_request)
    end

    # The create action render call when format is HTML    
    def create_respond_to_html
      if comment.persisted?
        redirect_to(post, 
          notice: t(:successfully_added_comment, scope: 'blogit.comments'))
      else
        render "blogit/posts/show"
      end  
    end
    
    # The comment attribute params 
    # 
    # Returns a Hash
    def comment_params
      params.require(:comment).permit(:name, :nickname, :email, :body, :website)
    end
    
  end
  
end