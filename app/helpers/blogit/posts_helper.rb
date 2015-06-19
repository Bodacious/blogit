module Blogit
  module PostsHelper
    
    require "blogit/archive"
    
    # A comments tag corresponding to the comments configuration
    def comments_for_post(post)
      comment_type = Blogit.configuration.include_comments
      render(partial: "blogit/comments/#{comment_type}_comments", 
        locals: { post: post, comment: Blogit::Comment.new })
    end

    # A share bar as configured
    def share_bar_for_post(post)
      return "" unless Blogit.configuration.include_share_bar
      render(partial: "blogit/posts/share_bar", locals: { post: post})
    end
    
    def related_posts_for_post(post)
      post.find_related_on_tags
    end


    # TODO: Create an object for handling this
    #
    # Creates a ul tag tree with posts by year and months. Include blogit/archive.js in
    # your js to enabled expand collapse.
    def archive_list_for_posts(archive_posts)
      render Blogit::Archive::List.new(archive_posts)
    end

  end

end
