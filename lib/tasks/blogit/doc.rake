namespace :blogit do
  desc "Alias of blogit:doc:compile"
  task doc: [:"doc:compile"]

  namespace :doc do
    DOC_FILES = ["Contributing", "TODOS", "Upgrading", "HowTo"].map do |filename|
      "./doc/#{filename}.md"
    end.join(",")

    desc "Builds the blogit documentation using YARD-Tomdoc"
    task compile: :environment do
      system("yard --plugin tomdoc --markup markdown --readme ./doc/Home.md "\
      "--files #{DOC_FILES} "\
      "--title 'Blogit - Add a blog to your Ruby on Rails application'")
    end
  end
end
