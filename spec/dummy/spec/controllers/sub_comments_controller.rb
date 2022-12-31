require "rails_helper"

describe SubCommentsController do
  let(:blog_post) { build(:post) }

  before do
    reset_configuration
  end

  it "is a subclass of Blogit::CommentsController" do
    expect(described_class.superclass).to eq(Blogit::CommentsController)
  end



  describe "POST 'create'" do
    before do
      Post.expects(:active_with_id).with("1").returns(blog_post)
      blog_post.expects(:comments).returns(relation_obj)
      relation_obj.expects(:new).returns(comment)
    end

    let(:relation_obj) { stub }

    let(:blog_post) { build(:post) }

    let(:comment) { build(:comment) }

    def do_post(post_id = "1")
      post :create, params: { post_id: post_id, comment: attributes_for(:comment) }
    end

    context "when super is called with a block" do
      it "yields the block with comment" do
        Timecop.freeze do
          comment.expects(:touch).with(:updated_at)
          do_post
        end
      end
    end
  end
end
