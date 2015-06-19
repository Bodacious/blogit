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
    # Creates a ul tag tree with posts by year and monthes. Include
    # blogit/archive.js to enabled expand collapse.
    # @param year_css [String, Symbol] The CSS class of the year UL tag
    # @param month_css [String, Symbol] The CSS class of the month UL tag
    # @param post_css [String, Symbol] The CSS class of the year LI tag
    # @param archive_posts [ActiveRecord::Relation, Array] The posts to be included in the archive (defaults to Post.all)
    # @yield[post] block responsible for writing the link (or whatever) to the post
    def archive_list_for_posts(archive_posts)
      render Blogit::Archive::List.new(archive_posts)
      # posts_tree = archive_posts.chunk do |post|
      #   post.created_at.year
      # end.map do |year, posts_in_year|
      #   [
      #     year, posts_in_year.chunk { |post|
      #     l(post.created_at, format: :plain_month_only)
      #     }
      #   ]
      # end
      #
      # result = ""
      # result << "<ul class=\"#{year_css}\">"
      # posts_tree.each do |year, posts_by_month|
      #   result << <<-HTML
      #   <li>
      #     <a data-blogit-click-to-toggle-children>#{year}</a>
      #     <ul class=\"#{month_css}\">
      #   HTML
      #   posts_by_month.each do |month, posts|
      #     result << "<li><a data-blogit-click-to-toggle-children>#{CGI.escape_html(month)}</a><ul class=\"#{post_css}\">"
      #     posts.each do |post|
      #       result << "<li>#{link_to(post.title, blogit.post_path(post))}</li>"
      #     end
      #     result << "</ul></li>"
      #   end
      #   result << "</ul></li>"
      # end
      # result << "</ul>"
      #
      # result.html_safe
    end

  end

end
