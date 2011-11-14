require 'spec_helper'

describe CommentsController do
  
  let(:blog_post) { Blogit::Post.first || create(:post) }
    
  describe "POST create" do
    
    before do
      @comment_attributes = attributes_for(:comment)
    end
    
    def do_post(format = :html)
      post :create, post_id: blog_post.id, 
        comment: @comment_attributes, use_route: :blogit, format: format
    end
    
    describe "whith JS" do
      
      it "should persist comment" do
        lambda { do_post(:js) }.should change { blog_post.comments.count }.by(1)
      end
      
      # The rest is handled in the view
      
    end
    
    describe "with HTML" do
      
      it "should persist comment" do
        lambda { do_post(:html) }.should change { blog_post.comments.count }.by(1)        
      end
      
      it "should redirect to the blog post" do
        do_post
        response.should redirect_to(controller.post_url(blog_post))
      end

      it "should display a flash notice" do
        do_post
        flash[:notice].should be_present
      end
      
    end
    
  end
  
  describe "DELETE destroy" do
    
    def do_delete(format = :html)
      delete :destroy, id: @comment.id,
        post_id: blog_post.id, format: format, use_route: :blogit
    end
    
    before do
      @comment  = create(:comment, post: blog_post)  
    end
    
    describe "when user logged in" do

      before do
        mock_login
      end
            
      describe "whith JS" do
        
        it "should destroy the comment" do
          lambda { do_delete(:js) }.should change { blog_post.reload.comments.count }
        end
        
      end

      describe "with HTML" do

        it "should destroy the comment" do
          lambda { do_delete(:html) }.should change { blog_post.reload.comments.count }
        end

        it "should redirect to the blog post " do
          do_delete
          response.should redirect_to(controller.post_url(blog_post))
        end

      end
      
    end
    
    describe "when user is not logged in" do
      
      
      describe "whith JS" do
        
        it 'should not destroy the comment' do
          lambda { do_delete }.should_not change { Comment.count }
        end
        
      end

      describe "with HTML" do

        it "should not destroy the comment" do
          lambda { do_delete }.should_not change { Comment.count }
        end

      end
      
    end
    
  end

end