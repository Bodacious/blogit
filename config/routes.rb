Blogit::Engine.routes.draw do
  
  resources :posts, except: [:index] do
    resources :comments, only: [:create, :destroy]
  end

  match "sitemap.xml" => 'posts#index', format: :xml

  match "page/:page" => "posts#index"

  match "posts/tagged/:tag" => 'posts#tagged', as: :tagged_blog_posts
  
  root to: "posts#index"
end