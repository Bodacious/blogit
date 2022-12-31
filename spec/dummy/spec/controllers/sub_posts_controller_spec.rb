require "rails_helper"

describe SubPostsController do
  let(:blog_post) { build(:post) }

  before do
    reset_configuration
  end

  it "is a subclass of Blogit::PostsController" do
    expect(described_class.superclass).to eq(Blogit::PostsController)
  end



  describe "GET 'index'" do
    before do
      Blogit::Post.expects(:for_index).with("").returns(posts)
    end

    let(:posts) { [] }

    def do_get(page = nil)
      get :index, params: { page: }
    end

    context "when super is called with a block" do
      it "yields the block with posts" do
        Timecop.freeze do
          posts.expects(:update_all).with(updated_at: Time.zone.now).returns([])
          do_get
        end
      end
    end
  end

  describe "GET 'tagged'" do
    before do
      Blogit::Post.expects(:for_index).with("").returns(posts)
      posts.expects(:tagged_with).returns(posts)
    end

    let(:posts) { [] }

    def do_get(page = nil)
      get :tagged, params: { page: page, tag: "one" }
    end

    context "when super is called with a block" do
      it "yields the block with posts" do
        Timecop.freeze do
          posts.expects(:update_all).with(updated_at: Time.zone.now).returns([])
          do_get
        end
      end
    end
  end

  describe "GET 'show'" do
    before do
      Blogit::Post.expects(:active_with_id).with("1").returns(post)
    end

    let(:post) { [] }

    def do_get(id = "1")
      get :show, params: { id: "1" }
    end

    context "when super is called with a block" do
      it "yields the block with posts" do
        post.expects(:touch).with(:updated_at)
        do_get
      end
    end
  end
end
