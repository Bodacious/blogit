module Blogit
  module PostsHelper

    # Creates a div tag with class 'blog_post_' + name
    # Eg:
    #   blog_post_tag(:title, "") # => <div class="blog_post_title"></div>
    def blog_post_tag(name, content_or_options = {}, options ={}, &block)
      if block_given?
        content = capture(&block)
        options = content_or_options
      else
        content = content_or_options
      end
      options[:class] = "#{options[:class]} blog_post_#{name}".strip
      content_tag(name, content, options)
    end

    # A comments tag corresponding to the comments configuration
    def comments_for(post)
      render(partial: "blogit/posts/#{Blogit.configuration.include_comments}_comments", locals: { post: post, comment: Blogit::Comment.new })
    end

    # Creates a ul tag tree with posts by year and monthes. Include
    # blogit/archive.js to enabled expand collapse.
    def blog_posts_archive_tag(year_css, month_css, post_css)
      posts_tree = Post.all.chunk {|post| post.created_at.year}.map do |year, posts_of_year|
        [year, posts_of_year.chunk {|post| l(post.created_at, format: :plain_month_only) }]
      end

      result = []

      result << "<ul class=\"#{year_css}\">"
      posts_tree.each do |year, posts_by_month|
        result << "<li><a onclick=\"toggleBrothersDisplay(this, 'UL')\">#{year}</a><ul class=\"#{month_css}\">"
        posts_by_month.each do |month, posts|
          result << "<li><a onclick=\"toggleBrothersDisplay(this, 'UL')\">#{CGI.escape_html(month)}</a><ul class=\"#{post_css}\">"
          posts.each do |post|
            result << "<li><a href=\"#{blogit.post_path(post)}\">#{CGI.escape_html(post.title)}</a></li>"
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
