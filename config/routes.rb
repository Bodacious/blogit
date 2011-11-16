Blogit::Engine.routes.draw do
  
  resources :posts, constraints: {id: /\d+[\-a-z]*/i}, only: [:index, :show] do
    resources :comments, only: [:create, :destroy]
  end
  
  # admin actions
  if Blogit.configuration.include_admin_actions
    resources :posts, only: [:new, :create, :edit, :update, :destroy]
  end
  
  match "/(page/:page)" => "posts#index"
  root to: "posts#index"
end