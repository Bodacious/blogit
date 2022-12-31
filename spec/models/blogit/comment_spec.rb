require "rails_helper"

describe Blogit::Comment do
  describe "should not be valid if it" do
    let(:comment) { build(:comment) }

    # nickname is a honey-pot
    it "has a value for nickname" do
      comment.nickname = "Gavin"
      expect(comment).not_to be_valid
      expect(comment.errors[:nickname].size).to eq(1)
    end

    it "doesn't have a value for name" do
      comment.name = ""
      expect(comment).not_to be_valid
      expect(comment.errors[:name].size).to eq(1)
    end

    it "doesn't have a value for email" do
      comment.email = ""
      expect(comment).not_to be_valid
      expect(comment.errors[:email].size).to be(1)
    end

    it "doesn't have a valid email" do
      comment.email = "notvalid.com"
      expect(comment).not_to be_valid
      expect(comment.errors[:email].size).to be(1)

      # has a space
      comment.email = "something else"
      expect(comment).not_to be_valid
      expect(comment.errors[:email].size).to be(1)

      # Has two @s
      comment.email = "gavin@gavin@notvalid.com"
      expect(comment).not_to be_valid
      expect(comment.errors[:email].size).to eq(1)
    end

    it "doesn't have a value for body" do
      comment.body = ""
      expect(comment).not_to be_valid
      expect(comment.errors[:body].size).to eq(1)
    end

    it "doesn't have at least 4 characters in the body" do
      comment.body = "abc"
      expect(comment).not_to be_valid
      expect(comment.errors[:body].size).to eq(1)
    end

    it "doesn't have a valid website url" do
      comment.website = "not valid"
      expect(comment).not_to be_valid
      expect(comment.errors[:website].size).to eq(1)
    end
  end
end
