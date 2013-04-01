Blogit::Engine.routes.draw do

  # Keep these above the posts resources block
  get "posts/page/:page" => "posts#index"

  resources :posts do
    resources :comments, only: [:create, :destroy]
  end

  get "/" => "posts#index", as: :blog_root
end
