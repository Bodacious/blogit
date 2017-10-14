require 'rails_helper'

describe Blogit::CommentsController do

  before do
    @routes = Blogit::Engine.routes
  end

  let(:blog_post) { Blogit::Post.active.first || create(:post, :active) }

  let(:comment_attributes) { attributes_for(:comment) }

  describe "POST create" do


    def do_post(format = :html)
      post :create, params: { post_id: blog_post.id,
        comment: comment_attributes }, format: format
    end

    subject { do_post(:js) }

    context "when POST is AJAX" do

      it "persists comment" do
        expect { subject }.to change { blog_post.comments.count }.by(1)
      end

      it "returns a status :created" do
        subject
        expect(response.status).to eql(201)
      end

    end

    describe "with HTML" do

      it "persists the comment" do
        expect { do_post(:html) }.to change { blog_post.comments.count }.by(1)
      end

      it "should redirect to the blog post" do
        do_post
        expect(response).to redirect_to(controller.post_url(blog_post))
      end

      it "should display a flash notice" do
        do_post
        expect(flash[:notice]).to be_present
      end

    end

  end

end