FactoryGirl.define do
  
  # =================
  # = Gem Factories =
  # =================
  factory :post, class: Blog::Post do
    title "Tis is a blog post title"
    body "This is the body of the blog post - you'll see it's a lot bigger than the title"
    association :blogger, :factory => :user
  end
  
  factory :comment, class: Blog::Comment do
    name "Gavin"
    email "gavin@gavinmorrice.com"
    website "http://gavinmorrice.com"
    body "I once saw a child the size of a tangerine!"
  end
  
  # =======================
  # = Dummy App Factories =
  # =======================
  factory :user do
    username "bodacious"
    password "password"
  end
  
end