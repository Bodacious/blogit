# Sub-class of Blogit::PostsController for testing calls to super with blocks
class SubPostsController < Blogit::PostsController
  
  def index
    super do |posts|
      posts.update_all(updated_at: Time.now)
    end
  end

  def tagged
    super do |posts|
      posts.update_all(updated_at: Time.now)
    end
  end
  
  def show
    super do |post|
      post.touch(:updated_at)
    end 
  end
  
end