user = User.create!(username: 'bodacious')

content = <<-CONTENT
Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. 
  
Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. 

Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
CONTENT

user.blog_posts.
  create!(title: "This is my first awesome blog post", body: content, state: :published,
    tag_list: "one, two, three")
    
user.blog_posts.
  create!(title: "This is my second awesome blog post", body: content, state: :published,
    tag_list: "two, three, four")