module Blog
  class CommentsController < ApplicationController

    expose(:post) { Blog::Post.find(params[:post_id]) }
    expose(:comments) { post.comments }
    expose(:comment)


    def create
      respond_to do |format|
        format.js
        
        format.html { 
          if comment.save 
            redirect_to(post, notice: "Successfully added comment!")
          else
            render "blog/posts/show"
          end
        }

      end

    end

  end
end
