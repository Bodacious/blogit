xml.instruct!
xml.rss "version" => "2.0", "xmlns:dc" => "htt://purl.org/dc/elements/1.1/" do
  xml.channel do

    xml.title blogit_conf.rss_feed_title

    xml.description blogit_conf.rss_feed_description

    xml.pubDate CGI.rfc1123_date @posts.first.try(:updated_at)

    xml.link blog_root_url

    xml.lastBuildDate CGI.rfc1123_date @posts.first.try(:updated_at)

    xml.language I18n.locale

    @posts.each do |post|

      xml.item do
        xml.title post.title
        xml.description format_content(post.short_body).html_safe
        xml.link post_url(post)
        xml.pubDate CGI.rfc1123_date(post.updated_at)
        xml.guid post_url(post)
        xml.author post.blogger_display_name
      end

    end
  end
end
