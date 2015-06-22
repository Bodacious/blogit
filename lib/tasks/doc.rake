
namespace :blogit do
  
  desc "Build the HTML docs for Blogit"
  task :doc do
    system("yard --plugin tomdoc --private --markup markdown --readme Blogit.md")
  end
  
end