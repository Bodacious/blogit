# -*- coding: utf-8 -*-

require "rails_helper"

describe Blogit::PostsHelper do
  describe "comments_for_post" do
    let(:post) { create(:post) }

    it "is empty if comments are not configured" do
      Blogit.configure do |config|
        config.include_comments = :no
      end

      expect(helper.comments_for_post(post)).to eq("")
    end

    it "is full html when comments use active record" do
      Blogit.configure do |config|
        config.include_comments = :active_record
      end

      comment = Blogit::Comment.new
      Blogit::Comment.expects(:new).returns(comment)
      helper.expects(:render).with(partial: "blogit/comments/active_record_comments", locals: { post:, comment: })
      helper.comments_for_post(post)
    end
  end

  describe "share_bar_for" do
    let(:post) { create(:post) }

    it "is empty if not configured" do
      Blogit.configure do |config|
        config.include_share_bar = false
      end

      expect(helper.share_bar_for_post(post)).to eq("")
    end

    it "renders a share bar if configured" do
      Blogit.configure do |config|
        config.include_share_bar = true
      end

      helper.expects(:render).with(partial: "blogit/posts/share_bar", locals: { post: }).returns(share_bar_html = '<div id="share-bar">...</div>')
      expect(helper.share_bar_for_post(post)).to eq(share_bar_html)
    end
  end
end
