require 'spec_helper'

describe Comment do
  
  describe "should not be valid if it" do

    let(:comment) { build(:comment) }

    # nickname is a honey-pot
    it "has a value for nickname" do
      comment.nickname = "Gavin"
      comment.should_not be_valid
      comment.should have(1).error_on(:nickname)
    end

    it "doesn't have a value for name" do
      comment.name = ""
      comment.should_not be_valid
      comment.should have(1).error_on(:name)
    end

    it "doesn't have a value for email" do
      comment.email = ""
      comment.should_not be_valid
      comment.should have(1).error_on(:email)
    end

    it "doesn't have a valid email" do
      comment.email = "notvalid.com"
      comment.should_not be_valid
      comment.should have(1).error_on(:email)

      # has a space
      comment.email = "something else"
      comment.should_not be_valid
      comment.should have(1).error_on(:email)

      # Has two @s
      comment.email = "gavin@gavin@notvalid.com"
      comment.should_not be_valid
      comment.should have(1).error_on(:email)
    end

    it "doesn't have a value for body" do
      comment.body = ""
      comment.should_not be_valid
      comment.should have(1).error_on(:body)
    end

    it "doesn't have at least 4 characters in the body" do
      comment.body = "abc"
      comment.should_not be_valid
      comment.should have(1).error_on(:body)
    end
    
    it "doesn't have a valid website url" do
      comment.website = "not valid"
      comment.should_not be_valid
      comment.should have(1).error_on(:website)
    end

  end
  
end