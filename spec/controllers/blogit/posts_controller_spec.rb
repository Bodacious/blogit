require 'spec_helper'

describe PostsController do

  before do
    reset_configuration
  end

  let(:blog_post) { build :post }

  describe "GET 'index'" do

    let(:posts) { [] }

    def do_get(page=nil)
      get :index, :use_route => :blogit, page: page.to_s
    end

    it "should set posts to Blogit::Post.for_index" do
      Blogit::Post.expects(:for_index).returns(posts)
      do_get
      assigns(:posts).should == posts
    end

    it "should pass the page param to for_index" do
      Blogit::Post.expects(:for_index).with("2").returns(posts)
      do_get("2")
      assigns(:posts).should == posts
    end

  end

  describe "GET /index.xml" do


    let(:posts) { [] }

    def do_get(page=nil)
      get :index, :use_route => :blogit, page: page.to_s, format: :xml
    end

    it "should load all posts in reverse date order" do
      Blogit::Post.expects(:order).with('created_at DESC').returns(posts)
      do_get
      assigns(:posts).should == posts
    end

  end

  describe "GET 'new'" do

    context "when logged in" do

      before do
        mock_login
      end

      def do_get
        get :new, use_route: :blogit
      end

      it "should be successful" do
        do_get
        response.should be_success
      end

      it "should set post to a new blog post" do
        do_get
        assigns(:post).should be_a(Blogit::Post)
        assigns(:post).should be_a_new_record
      end

    end

    context "when not logged in" do

      def do_get
        get :new, use_route: :blogit
      end

      # It's not really the responsibility of the gem to manage authentication
      # so testing for specific behaviour here is not required
      # at the very least though, we'd expect the status not to be 200
      it "should redirect to another page" do
        do_get
        response.should_not be_success
      end

    end
  end

  describe "POST /create" do

    context "when logged in" do

      before do
        mock_login
      end

      context "with valid params" do

        let(:post_attributes) { attributes_for(:post) }

        def do_post
          post :create, use_route: :blogit, post: post_attributes
        end

        before do
          @blog_posts = []
          @current_blogger.expects(:blog_posts).returns(@blog_posts)
          @blog_posts.expects(:new).with(post_attributes.stringify_keys).returns(blog_post)
          blog_post.expects(:save).returns(true)
        end

        it "should redirect to the blog post page" do
          do_post
          response.should redirect_to(controller.posts_url)
        end
        
        it "should ping all search engines in ping_search_engines config if array" do
          Blogit.configuration.ping_search_engines = search_engines = [:google]
          search_engines.each do |search_engine|
            Pingr::Request.expects(:new).with(search_engine, controller.posts_url(format: :xml))
          end
          do_post
        end

        it "should ping all search engines in Pingr::SUPPORTED_SEARCH_ENGINES if config is true" do
          Blogit.configuration.ping_search_engines = true
          Pingr::SUPPORTED_SEARCH_ENGINES.each do |search_engine|
            Pingr::Request.expects(:new).with(search_engine, controller.posts_url(format: :xml))
          end
          do_post
        end

        it "should not ping any search engines if ping_search_engines is false" do
          Blogit.configuration.ping_search_engines = false
          Pingr::SUPPORTED_SEARCH_ENGINES.each do |search_engine|
            Pingr::Request.expects(:new).with(search_engine, controller.posts_url(format: :xml)).never
          end
          do_post
        end
      end

    end

  end


  describe "GET 'edit'" do

    context "when logged in" do

      before do
        mock_login
        @current_blogger.expects(:blog_posts).returns(@blog_posts = [])
        @blog_posts.expects(:find).with("1").returns(blog_post)
      end

      def do_get
        get :edit, :id => 1, use_route: :blogit
      end

      it "should find the blog post by the ID" do
        do_get
        assigns(:post).should eql(blog_post)
      end

    end

    context "when not logged in" do

      def do_get
        get :edit, :id => 1, use_route: :blogit
      end

      # It's not really the responsibility of the gem to manage authentication
      # so testing for specific behaviour here is not required
      # at the very least though, we'd expect the status not to be 200
      it "should redirect to another pages" do
        do_get
        response.should_not be_success
      end

    end

  end

  describe "PUT 'update'" do

    context "when logged in" do

      before do
        @post_attributes = { "title" => "Something new" }
        mock_login
        @current_blogger.expects(:blog_posts).returns(@blog_posts = [])
        @blog_posts.expects(:find).with("1").returns(blog_post)
      end

      def do_put
        put :update, id: "1", use_route: :blogit, post: @post_attributes
      end

      it "should update the post attributes from params" do
        blog_post.expects(:update_attributes).with(@post_attributes).returns(true)
        do_put
      end

      it "should redirect to the blog post page" do
        do_put
        response.should redirect_to(controller.post_url(blog_post))
      end

      it "should set a flash notice" do
        do_put
        flash[:notice].should be_present
      end
      
      it "should ping all search engines in ping_search_engines config if array" do
        Blogit.configuration.ping_search_engines = search_engines = [:google, :bing]
        search_engines.each do |search_engine|
          Pingr::Request.expects(:new).with(search_engine, controller.posts_url(format: :xml))
        end
        do_put
      end

      it "should ping all search engines in Pingr::SUPPORTED_SEARCH_ENGINES if config is true" do
        Blogit.configuration.ping_search_engines = true
        Pingr::SUPPORTED_SEARCH_ENGINES.each do |search_engine|
          Pingr::Request.expects(:new).with(search_engine, controller.posts_url(format: :xml))
        end
        do_put
      end

      it "should not ping any search engines if ping_search_engines is false" do
        Blogit.configuration.ping_search_engines = false
        Pingr::SUPPORTED_SEARCH_ENGINES.each do |search_engine|
          Pingr::Request.expects(:new).with(search_engine, controller.posts_url(format: :xml)).never
        end
        do_put
      end
      
    end

    context "when not logged in" do

      before do
        @post_attributes = { "title" => "Something new" }
      end

      def do_put
        put :update, id: "1", use_route: :blogit, post: @post_attributes
      end

      # It's not really the responsibility of the gem to manage authentication
      # so testing for specific behaviour here is not required
      # at the very least though, we'd expect the status not to be 200
      it "should redirect to another page" do
        do_put
        response.should_not be_success
      end

    end

  end

  describe "GET 'show'" do

    before do
      Blogit::Post.expects(:find).with("1").returns(blog_post)
    end

    def do_get
      get :show, :id => 1, use_route: :blogit
    end

    it "should find blog post by id" do
      do_get
      assigns(:post).should eql(blog_post)
    end

  end

  describe "DELETE 'destroy'" do

    def do_delete
      delete :destroy, id: "1", use_route: :blogit
    end

    describe "when logged in" do

      before do
        mock_login
        @current_blogger.expects(:blog_posts).returns(@blog_posts = [])
        @blog_posts.expects(:find).with("1").returns(blog_post)
      end

      it "should destroy the blog post" do
        blog_post.expects(:destroy)
        do_delete
      end

      it "should redirect to the blog posts url" do
        do_delete
        response.should redirect_to(controller.posts_url)
      end

      it "should show a flash notice" do
        do_delete
        flash[:notice].should be_present
      end
      
      it "should ping all search engines in ping_search_engines config if array" do
        Blogit.configuration.ping_search_engines = search_engines = [:google, :bing]
        search_engines.each do |search_engine|
          Pingr::Request.expects(:new).with(search_engine, controller.posts_url(format: :xml))
        end
        do_delete
      end

      it "should ping all search engines in Pingr::SUPPORTED_SEARCH_ENGINES if config is true" do
        Blogit.configuration.ping_search_engines = true
        Pingr::SUPPORTED_SEARCH_ENGINES.each do |search_engine|
          Pingr::Request.expects(:new).with(search_engine, controller.posts_url(format: :xml))
        end
        do_delete
      end

      it "should not ping any search engines if ping_search_engines is false" do
        Blogit.configuration.ping_search_engines = false
        Pingr::SUPPORTED_SEARCH_ENGINES.each do |search_engine|
          Pingr::Request.expects(:new).with(search_engine, controller.posts_url(format: :xml)).never
        end
        do_delete
      end

    end

    describe "when not logged in" do

      it "should redirect to another page" do
        do_delete
        response.should_not be_success
      end

    end

  end

end
