Rails.application.routes.draw do

  resource :session, :only => [:new, :create, :destroy]

  mount Blog::Engine => "/blog"
  
  resources :users  
  
  root :to => "blog/posts#index"
  
end
