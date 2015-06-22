require 'rails_helper'

describe Blogit::PostsController do

  before do
    reset_configuration
    @routes = Blogit::Engine.routes
  end

  let(:blog_post) { build :post }

  describe "GET 'index'" do

    let(:posts) { [] }

    def do_get(page=nil)
      get :index, page: page 
    end

    it 'sets posts to Blogit::Post.for_index' do
      Blogit::Post.expects(:for_index).returns(posts)
      do_get
      expect(assigns(:posts)).to eql(posts)
    end
    
    context "when a page param is present" do

      it 'passes the page param on to Blogit::Post.for_index' do
        Blogit::Post.expects(:for_index).with('2').returns(posts)
        do_get('2')
        expect(assigns(:posts)).to eql(posts)
      end
      
    end

    context "when a custom layout is set" do
      
      before do
        Blogit.configuration.layout = "custom"
        # Force re-load the Blogit::PostsController
        load(File.join(File.dirname(__FILE__), "../../..", "app", "controllers",
          "blogit", "posts_controller.rb"))  
      end
      
      it "uses use the specified layout" do
        do_get
        expect(response).to render_template("layouts/custom")
      end

    end

  end

  describe "GET /index.xml" do


    let(:posts) { [] }

    def do_get(page=nil)
      get :index, page: page.to_s, format: :xml
    end

    it "loads all posts in reverse date order" do
      Blogit::Post.stubs(:active).returns(posts)
      Blogit::Post.expects(:for_feed).returns(posts)
      do_get
      expect(assigns(:posts)).to eql(posts)
    end

  end

  describe "GET 'show'" do

    before do
      Blogit::Post.expects(:active_with_id).with("1").returns(blog_post)
    end

    def do_get
      get :show, :id => 1
    end

    it "finds blog post by id" do
      do_get
      expect(assigns(:post)).to eql(blog_post)
    end

  end

end