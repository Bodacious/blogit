module Blogit
  class CommentsController < ApplicationController

    blogit_authenticate except: [:create]
    
    expose(:post) { Blogit::Post.find(params[:post_id]) }
    expose(:comments) { post.comments }
    expose(:comment) { 
      case params[:action]
      when /create/ then comments.new(params[:comment])
      when /destroy/ then comments.find(params[:id])
      end
    }


    def create
      respond_to do |format|
        format.js {
          # the rest is dealt with in the view
          comment.save
        }

        format.html { 
          if comment.save 
            redirect_to(post, notice: "Successfully added comment!")
          else
            render "blogit/posts/show"
          end
        }

      end

    end

    def destroy
      comment.destroy
      respond_to do |format|
        format.html { redirect_to(post, notice: "Successfully removed comment.") }        
        format.js
      end
    end

  end
end
