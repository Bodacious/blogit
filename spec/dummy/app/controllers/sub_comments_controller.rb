# Sub-class of Blogit::PostsController for testing calls to super with blocks
class SubCommentsController < Blogit::CommentsController
  
  def create
    super do |comment|
      comment.touch(:updated_at)
    end
  end
  
end