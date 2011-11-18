module Blogit
  
  class BlogitSweeper < ActionController::Caching::Sweeper

    observe Blogit::Post, Blogit::Comment

  end
  
end