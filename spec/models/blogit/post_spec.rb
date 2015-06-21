require "rails_helper"
  
describe Blogit::Post do

  context "should not be valid" do

    context "if blogger" do
      
      let(:blog_post) { Blogit::Post.new }

      it "is nil" do
        expect(blog_post).not_to be_valid
        expect(blog_post).to have(1).error_on(:blogger_id)
      end

    end

    context "if title" do
      before do
        @blog_post = Blogit::Post.new
      end

      after do
        expect(@blog_post).not_to be_valid
        expect(@blog_post.errors[:title]).not_to be_blank
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
        expect(@blog_post).not_to be_valid
        expect(@blog_post.errors[:body]).not_to be_blank
      end

      it "is blank" do
        # defined above
      end

      it "is shorter than 10 characters" do
        @blog_post.body = "a" * 9
      end

    end

    context "if state" do

      before(:each) { @blog_post = Blogit::Post.new(state: nil) }

      it "is nil" do
        expect(@blog_post).not_to be_valid
        expect(@blog_post).to have(1).error_on(:state)
      end

    end

  end

  it "sets the first value of Blogit::configuration.hidden_states as default" do
    expect(Blogit::Post.new.state).to eql(Blogit::configuration.hidden_states[0].to_s)
  end

  context "with Blogit.configuration.comments == active_record" do
    it "should allow comments" do
      Blogit.configure do |config|
        # this should be :active_record by default anyway
        config.include_comments = :active_record
      end
      User.blogs
      @blog_post = Blogit::Post.new
      expect { @blog_post.comments }.not_to raise_exception
    end

  end

  describe "blogger_display_name" do

    before :all do
      User.blogs
    end

    let(:user) { User.create! username: "Jeronimo", password: "password" }

    it "should return the display name of the blogger if set" do
      @post = user.blog_posts.build
      expect(@post.blogger_display_name).to eq("Jeronimo")
      Blogit.configuration.blogger_display_name_method = :password
      expect(@post.blogger_display_name).to eq("password")
    end

    it "should return an empty string if blogger doesn't exist" do
      Blogit.configuration.blogger_display_name_method = :username
      @post = Blogit::Post.new
      expect(@post.blogger_display_name).to eq("")
    end

    it "should raise an exception if blogger display_name method doesn't exist" do
      Blogit.configuration.blogger_display_name_method = :display_name
      @post = user.blog_posts.build
      expect { @post.blogger_display_name }.to raise_exception(Blogit::ConfigurationError)
    end

  end

  describe "scopes" do

    describe :for_index do

      before :all do
        Blogit::Post.destroy_all
        15.times { |i| create(:post, :active, created_at: i.days.ago) }
      end

      it "should order posts by created_at DESC" do
        expect(Blogit::Post.for_index.first).to eq(Blogit::Post.order("created_at DESC").first)
      end

      it "should paginate posts in blocks of 5" do
        expect(Blogit::Post.for_index.count).to eq(5)
      end

      it "should accept page no as an argument" do
        expect(Blogit::Post.for_index(2)).to eq(Blogit::Post.active.
          order("created_at DESC").offset(5).limit(5))
      end

      it "should change the no of posts per page if paginates_per is set" do
        Blogit::Post.paginates_per 3
        expect(Blogit::Post.for_index.count).to eql(3)
      end

    end

    describe :active do
      it 'should include only posts in active states blogit.config.active_states' do
        published_post = create(:post, :active)
        expect(Blogit::Post.active).to include (published_post)
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
      expect { @blog_post.comments }.to raise_exception(RuntimeError)
    end

  end

  describe "body preview" do
    it "should not truncate a short body" do
      post = Blogit::Post.new(body: "short body")

      expect(post.short_body).to eq(post.body)
    end

    it "should not truncate a long body" do
      post = Blogit::Post.new(body: "t\n"*300)

      expect(post.short_body).to eq("t\n"*198 + "t...")
    end

    it "should not cut the body in the middle of an image declaration" do
      body = "some text\n"*35 + '"!http://www.images.com/blogit/P6876.thumb.jpg(Look at this)!\":http://www.images.com/blogit/P6976.jpb'
      post = Blogit::Post.new(body: body)

      expect(post.short_body).not_to include('"!http://www.images.com')
    end
  end
  
  describe "blogger_twitter_username" do
    
    let(:post) { build(:post) }
    
    context "when the blogger responds to :twitter_username" do
      
      before do
        class << post.blogger
          def twitter_username
            "@gavin_morrice"
          end
        end
      end
      
      it "returns the blogger's twitter username" do
        expect(post.blogger_twitter_username).to eql("@gavin_morrice")
      end
      
    end
    
    context "when the blogger doesn't respond to :twitter_username" do
      
      before do
        Blogit.configuration.twitter_username = '@katana_code'
      end

      it "returns nil" do
        expect(post.blogger_twitter_username).to be_nil
      end
      
    end
  end
  
  describe 'AVAILABLE_STATUS'  do
    it "returns all the statues in Blogit::configuration" do
      expect(Blogit::Post::AVAILABLE_STATUS).to  eq(Blogit.configuration.hidden_states + Blogit.configuration.active_states)
    end
    
  end
end
