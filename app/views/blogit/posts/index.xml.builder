xml.instruct!
xml.urlset :xmlns => 'http://www.sitemaps.org/schemas/sitemap/0.9' do

  # Show the blog index in sitemap
  xml.url do
    xml.loc posts_url
    xml.lastmod @posts.maximum(:updated_at).xmlschema
  end

  # Include a record for each active post
  for post in @posts
    xml.url do
      xml.loc post_url(post)
      xml.lastmod post.updated_at.xmlschema
    end
  end

end