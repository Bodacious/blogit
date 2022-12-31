Rails.application.routes.draw do
  resource :session, only: %i(new create destroy)

  mount Blogit::Engine => "/blog"

  resources :sub_posts, controller: "sub_posts" do
    collection do
      get :tagged
    end
  end

  post "sub_posts/:post_id/comments" => "sub_comments#create"

  resources :users

  root to: "blogit/posts#index"
end
