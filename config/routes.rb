Blogit::Engine.routes.draw do

  # Keep these above the posts resources block
  match "posts/page/:page" => "posts#index"
  match "posts/tagged/:tag" => 'posts#tagged', as: :tagged_blog_posts

  resources :posts do
    resources :comments, only: [:create, :destroy]
  end

  match "/" => "posts#index", as: :blog_root
end
