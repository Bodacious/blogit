Blogit::Engine.routes.draw do
    
  resources :posts, except: [:index] do
    resources :comments, only: [:create, :destroy]
  end
  
  match "/(page/:page)" => "posts#index"
  root to: "posts#index"
end