module Blogit
  module PostsHelper

    # A comments tag corresponding to the comments configuration
    def comments_for(post)
      render(partial: "blogit/posts/#{Blogit.configuration.include_comments}_comments", locals: { post: post, comment: Blogit::Comment.new })
    end

    # A share bar as configured
    def share_bar_for(post)
      return "" unless Blogit.configuration.include_share_bar
      render(partial: "blogit/posts/share_bar", locals: { post: post})
    end

    # Creates a ul tag tree with posts by year and monthes. Include
    # blogit/archive.js to enabled expand collapse.
    # @param year_css [String, Symbol] The CSS class of the year UL tag
    # @param month_css [String, Symbol] The CSS class of the month UL tag
    # @param post_css [String, Symbol] The CSS class of the year LI tag
    # @param archive_posts [ActiveRecord::Relation, Array] The posts to be included in the archive (defaults to Post.all)
    # @yield[post] block responsible for writing the link (or whatever) to the post
    def blog_posts_archive_tag(year_css, month_css, post_css, archive_posts = Post.order("created_at DESC"))
      posts_tree = archive_posts.chunk {|post| post.created_at.year}.map do |year, posts_of_year|
        [year, posts_of_year.chunk {|post| l(post.created_at, format: :plain_month_only) }]
      end

      result = []
      result << "<ul class=\"#{year_css}\">"
      posts_tree.each do |year, posts_by_month|
        result << "<li><a data-blogit-click-to-toggle-children>#{year}</a><ul class=\"#{month_css}\">"
        posts_by_month.each do |month, posts|
          result << "<li><a data-blogit-click-to-toggle-children>#{CGI.escape_html(month)}</a><ul class=\"#{post_css}\">"
          posts.each do |post|
            result << "<li>#{yield post}</li>"
          end
          result << "</ul></li>"
        end
        result << "</ul></li>"
      end
      result << "</ul>"

      result.join.html_safe
    end

  end

end
