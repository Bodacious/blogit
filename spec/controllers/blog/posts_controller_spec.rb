require 'spec_helper'

describe PostsController do


  describe "GET 'index'" do

    let(:posts) { [] }
    
    def do_get(page=nil)
      get :index, :use_route => :blog, page: page.to_s
    end
    
    it "should set posts to Blog::Post.for_index" do
      Blog::Post.expects(:for_index).returns(posts)
      do_get
      controller.posts.should == posts
    end
    
    it "should pass the page param to for_index" do
      Blog::Post.expects(:for_index).with("2").returns(posts)
      do_get("2")
      controller.posts.should == posts
    end
    
  end
  
  describe "GET 'new'" do
    
    context "when logged in" do
      
      before do
        mock_login
        reset_configuration
      end
      
      def do_get
        get :new, use_route: :blog
      end
    
      it "should be successful" do
        do_get
        response.should be_success
      end
      
      it "should set post to a new blog post" do
        do_get
        controller.post.should be_a(Blog::Post)
        controller.post.should be_a_new_record
      end
      
    end
    
    context "when not logged in" do
      
      def do_get
        get :new, use_route: :blog
      end
      
      # It's not really the responsibility of the gem to manage authentication 
      # so testing for specific behaviour here is not required
      # at the very least though, we'd expect the status not to be 200
      it "should redirect to another pages" do
        do_get
        response.should_not be_success
      end
      
    end
  end
  
  describe "POST /create" do
    
    context "when logged in" do
      
      before do
        mock_login
        reset_configuration
      end
      
      context "with valid params" do
        
        let(:post_attributes) { attributes_for(:post) }
        let(:blog_post) { build :post }
        
        def do_post
          post :create, use_route: :blog, post: post_attributes
        end
        
        before do
          @blog_posts = []
          @current_blogger.expects(:blog_posts).returns(@blog_posts)
          @blog_posts.expects(:new).with(post_attributes.stringify_keys).returns(blog_post)
          blog_post.expects(:save).returns(true)
        end
                
        it "should redirect to the blog post page" do
          do_post
          response.should redirect_to(controller.posts_url)
        end
        
      end
      
    end
    
  end

  
  describe "GET 'edit'" do
    
    context "when logged in" do
      
      let(:blog_post) { build :post }
      
      before do
        mock_login
        @blog_posts = []
        @current_blogger.expects(:blog_posts).returns(@blog_posts)
        @blog_posts.expects(:find).with("1").returns(blog_post)
      end
      
      def do_get
        get :edit, :id => 1, use_route: :blog
      end
      
      it "should find the blog post by the ID" do
        do_get
        controller.post.should eql(blog_post)
      end
      
    end
    
    context "when not logged in" do
      
      def do_get
        get :edit, :id => 1, use_route: :blog
      end
      
      # It's not really the responsibility of the gem to manage authentication 
      # so testing for specific behaviour here is not required
      # at the very least though, we'd expect the status not to be 200
      it "should redirect to another pages" do
        do_get
        response.should_not be_success
      end
      
    end

  end
  
  describe "PUT 'update'" do
    
    context "when logged in" do
      
      before do
        mock_login
        reset_configuration
      end
      
      it "should update the post attributes from params" do
        
      end
    end
    
    context "when not logged in" do
      
    end
    
  end
  
  describe "GET 'show'" do
    
    let(:blog_post) { build(:post) }
    
    before do
      Blog::Post.expects(:find).with("1").returns(blog_post)
    end
    
    def do_get
      get :show, :id => 1, use_route: :blog
    end
    
    it "should find blog post by id" do
      do_get
      controller.post.should eql(blog_post)
    end

  end

end
