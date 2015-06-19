FactoryGirl.define do
  
  # =================
  # = Gem Factories =
  # =================
  factory :post, class: Blogit::Post do
    title "This is a blog post title"
    description "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    body "This is the body of the blog post - you'll see it's a lot bigger than the title"
    state "draft"
    association :blogger, :factory => :user
    factory :published_post do
      state "published"
    end
  end

  factory :comment, class: Blogit::Comment do
    name "Gavin"
    email "gavin@gavinmorrice.com"
    website "http://gavinmorrice.com"
    body "I once saw a child the size of a tangerine!"
    post
  end
  
  # =======================
  # = Dummy App Factories =
  # =======================
  factory :user do
    username "bodacious"
    password "password"
  end
  
end