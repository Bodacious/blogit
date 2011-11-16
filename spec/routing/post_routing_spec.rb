require "spec_helper"

# TODO: Find out how to spec routes in a Mounted engine :S
describe PostsController do
  describe "routing" do
    
    before do
      Blogit.configuration.include_admin_actions = true
    end

    describe "when Blogit.configuration.include_admin_actions is true" do

      before do
        Blogit.configuration.include_admin_actions = true
      end
      
    end

    describe "when Blogit.configuration.include_admin_actions is false" do

      before do
        Blogit.configuration.include_admin_actions = false 
      end

    end

  end
end
