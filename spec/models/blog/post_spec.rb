require "spec_helper"

describe Blog::Post do
  
  context "should not be valid" do
    
    context "if blogger" do
      
      it "is nil" do
        @blog_post = Blog::Post.new
        @blog_post.should_not be_valid
        @blog_post.should have(1).error_on(:blogger_id)
      end
      
    end
    
    context "if title" do
      before do
        @blog_post = Blog::Post.new
      end

      after do
        @blog_post.should_not be_valid
        @blog_post.errors[:title].should_not be_blank
      end

      it "is blank" do
        # before and after block cover this
      end

      it "is less than 10 characters" do
        @blog_post.title = "a" * 9
      end

      it "is longer than 66 characters" do
        @blog_post.title = "a" * 67
      end
            
    end
    
    context "if body" do
      before do
        @blog_post = Blog::Post.new
      end

      after do
        @blog_post.should_not be_valid
        @blog_post.errors[:body].should_not be_blank
      end
      
      it "is blank" do
        # defined above
      end
      
      it "is shorter than 10 characters" do
        @blog_post.body = "a" * 9
      end
      
    end
    
  end
  
  context "with Blog.configuration.comments == true" do
    it "should have many comments if " do
      Blog.configure do |config|
        # this should be true by default anyway
        config.include_comments = true
      end
      User.blogs
      @blog_post = Blog::Post.new
      lambda { @blog_post.comments }.should_not raise_exception(NoMethodError)
    end
    
  end
  
  describe "blogger_display_name" do
    
    before :all do
      User.blogs
    end
    
    let(:user) { User.create! username: "Jeronimo", password: "password" }
    
    it "should return the display name of the blogger if set" do
      @post = user.blog_posts.build
      @post.blogger_display_name.should == "Jeronimo"
      Blog.configuration.blogger_display_name_method = :password
      @post.blogger_display_name.should == "password"
    end
    
    it "should return an empty string if blogger doesn't exist" do
      Blog.configuration.blogger_display_name_method = :username
      @post = Blog::Post.new
      @post.blogger_display_name.should == ""
    end

    it "should raise an exception if blogger display_name method doesn't exist" do
      Blog.configuration.blogger_display_name_method = :display_name
      @post = user.blog_posts.build
      lambda { @post.blogger_display_name }.should raise_exception(Blog::ConfigurationError)
    end
    
  end
  
  describe "scopes" do
        
    describe :for_index do
      
      before :all do
        Blog::Post.destroy_all
        15.times { |i| create :post, updated_at: i.days.ago }
      end
      
      it "should order posts by updated_at DESC" do
        Blog::Post.for_index.first.should == Blog::Post.order("updated_at DESC").first
      end
      
      it "should paginate posts in blocks of 5" do
        Blog::Post.for_index.count.should == 5
      end
      
      it "should accept page no as an argument" do
        Blog::Post.for_index(2).should == Blog::Post.order("updated_at DESC").offset(5).limit(5)
      end
      
      it "should change the no of posts per page if paginates_per is set" do
        Blog::Post.paginates_per 3
        Blog::Post.for_index.count.should eql(3)
      end
      
      
    end
    
    
  end
  

  # TODO: Find a better way to test this
  # describe "with Blog.configuration.comments == false" do
  # 
  #   it "should not have many comments if Blog.configuration.comments == false" do
  #     Blog.configure do |config|
  #       # this should be true by default anyway
  #       config.include_comments = false
  #     end
  #     User.blogs
  #     @blog_post = Blog::Post.new
  #     lambda { @blog_post.comments }.should raise_exception(NoMethodError)
  #   end
  # 
  # end
  
end