xml.instruct! 
xml.urlset :xmlns => 'http://www.sitemaps.org/schemas/sitemap/0.9' do 

  for post in @posts
    xml.url do
      xml.loc post_url(post)
      xml.lastmod post.updated_at.xmlschema
    end
  end
  
end