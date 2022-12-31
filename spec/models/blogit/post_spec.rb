require "rails_helper"

describe Blogit::Post do
  context "when validating" do
    context "with blogger" do
      let(:blog_post) { described_class.new }

      it "is nil" do
        expect(blog_post).not_to be_valid
        expect(blog_post.errors[:blogger_id].size).to eq(1)
      end
    end

    context "with title" do
      let(:blog_post) { described_class.new }

      it "is less than 10 characters" do
        blog_post.title = "a" * 9

        expect(blog_post).not_to be_valid
        expect(blog_post.errors[:title]).not_to be_blank
      end

      it "is longer than 66 characters" do
        blog_post.title = "a" * 67

        expect(blog_post).not_to be_valid
        expect(blog_post.errors[:title]).not_to be_blank
      end
    end

    context "with body" do
      let(:blog_post) { described_class.new }

      it "is blank" do
        expect(blog_post).not_to be_valid
        expect(blog_post.errors[:body]).not_to be_blank
      end

      it "is shorter than 10 characters" do
        blog_post.body = "a" * 9

        expect(blog_post).not_to be_valid
        expect(blog_post.errors[:body]).not_to be_blank
      end
    end

    context "with state" do
      let(:blog_post) { described_class.new(state: nil) }

      it "is nil" do
        expect(blog_post).not_to be_valid
        expect(blog_post.errors[:state].size).to eq(1)
      end
    end
  end

  it "sets the first value of Blogit::configuration.hidden_states as default" do
    expect(described_class.new.state).to eql(Blogit::configuration.hidden_states[0].to_s)
  end

  context "with Blogit.configuration.comments == active_record" do
    before do
      User.blogs
    end

    let(:blog_post) { described_class.new }

    it "allows comments" do
      Blogit.configure do |config|
        # this should be :active_record by default anyway
        config.include_comments = :active_record
      end

      expect { blog_post.comments }.not_to raise_exception
    end
  end

  describe "#blogger_display_name" do
    before do
      Blogit.configuration.blogger_display_name_method = :username

      User.blogs
    end

    let(:post) { described_class.new(blogger: user) }

    let(:user) { User.create! username: "Jeronimo", password: "password" }

    it "returns the display name of the blogger if set" do
      expect(post.blogger_display_name).to eq("Jeronimo")

      Blogit.configuration.blogger_display_name_method = :password

      expect(post.blogger_display_name).to eq("password")
    end

    it "returns an empty string if blogger doesn't exist" do
      post = described_class.new

      expect(post.blogger_display_name).to eq("")
    end

    it "raises an exception if blogger display_name method doesn't exist" do
      Blogit.configuration.blogger_display_name_method = :notamethod

      post = user.blog_posts.build
      expect { post.blogger_display_name }.to raise_exception(Blogit::ConfigurationError)
    end
  end

  describe "scopes" do
    describe ".for_index" do
      before do
        described_class.destroy_all
        15.times { |i| create(:post, :active, created_at: i.days.ago) }
      end

      it "orders posts by created_at DESC" do
        expect(described_class.for_index.first).to eq(described_class.order("created_at DESC").first)
      end

      it "paginates posts in blocks of 5" do
        expect(described_class.for_index.count).to eq(5)
      end

      it "accepts page no as an argument" do
        expect(described_class.for_index(2)).to eq(described_class.active.
          order("created_at DESC").offset(5).limit(5))
      end

      it "changes the no of posts per page if paginates_per is set" do
        described_class.paginates_per 3
        expect(described_class.for_index.count).to be(3)
      end
    end

    describe ".active" do
      it "includes only posts in active states blogit.config.active_states" do
        published_post = create(:post, :active)
        expect(described_class.active).to include (published_post)
      end
    end
  end

  describe "with Blogit.configuration.comments != active_record" do
    before { User.blogs }

    it "does not allow comments" do
      Blogit.configure do |config|
        config.include_comments = :no
      end
      blog_post = described_class.new
      expect { blog_post.comments }.to raise_exception(RuntimeError)
    end
  end

  describe "#short_body" do
    let(:post) { build(:post) }

    context "when Blogit.configuration.show_post_description is true" do
      before do
        Blogit.configuration.show_post_description = true
      end

      it "returns the Post's description" do
        expect(post.short_body).to eq(post.description)
      end
    end

    context "when Blogit.configuration.show_post_description is false" do
      before do
        Blogit.configuration.show_post_description = false
      end

      it "returns the Post's description" do
        expect(post.short_body).to eq(post.body)
      end
    end
  end

  describe "blogger_twitter_username" do
    let(:post) { build(:post) }

    context "when the blogger responds to :twitter_username" do
      before do
        class << post.blogger
          def twitter_username
            "@twitter-username"
          end
        end
      end

      it "returns the blogger's twitter username" do
        expect(post.blogger_twitter_username).to eql("@twitter-username")
      end
    end

    context "when the blogger doesn't respond to :twitter_username" do
      before do
        Blogit.configuration.twitter_username = "@twitter-username"
      end

      it "returns nil" do
        expect(post.blogger_twitter_username).to be_nil
      end
    end
  end
end
