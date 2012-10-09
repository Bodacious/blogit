require "spec_helper"

describe Blogit::Post do

  context "should not be valid" do

    context "if blogger" do

      it "is nil" do
        @blog_post = Blogit::Post.new
        @blog_post.should_not be_valid
        @blog_post.should have(1).error_on(:blogger_id)
      end

    end

    context "if title" do
      before do
        @blog_post = Blogit::Post.new
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
        @blog_post = Blogit::Post.new
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

  context "with Blogit.configuration.comments == active_record" do
    it "should allow comments" do
      Blogit.configure do |config|
        # this should be :active_record by default anyway
        config.include_comments = :active_record
      end
      User.blogs
      @blog_post = Blogit::Post.new
      lambda { @blog_post.comments }.should_not raise_exception(RuntimeError)
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
      Blogit.configuration.blogger_display_name_method = :password
      @post.blogger_display_name.should == "password"
    end

    it "should return an empty string if blogger doesn't exist" do
      Blogit.configuration.blogger_display_name_method = :username
      @post = Blogit::Post.new
      @post.blogger_display_name.should == ""
    end

    it "should raise an exception if blogger display_name method doesn't exist" do
      Blogit.configuration.blogger_display_name_method = :display_name
      @post = user.blog_posts.build
      lambda { @post.blogger_display_name }.should raise_exception(Blogit::ConfigurationError)
    end

  end

  describe "scopes" do

    describe :for_index do

      before :all do
        Blogit::Post.destroy_all
        15.times { |i| create :post, created_at: i.days.ago }
      end

      it "should order posts by created_at DESC" do
        Blogit::Post.for_index.first.should == Blogit::Post.order("created_at DESC").first
      end

      it "should paginate posts in blocks of 5" do
        Blogit::Post.for_index.count.should == 5
      end

      it "should accept page no as an argument" do
        Blogit::Post.for_index(2).should == Blogit::Post.order("created_at DESC").offset(5).limit(5)
      end

      it "should change the no of posts per page if paginates_per is set" do
        Blogit::Post.paginates_per 3
        Blogit::Post.for_index.count.should eql(3)
      end


    end


  end


  describe "with Blogit.configuration.comments != active_record" do

    it "should not allow comments" do
      Blogit.configure do |config|
        config.include_comments = :no
      end
      User.blogs
      @blog_post = Blogit::Post.new
      lambda { @blog_post.comments }.should raise_exception(RuntimeError)
    end

  end

end
