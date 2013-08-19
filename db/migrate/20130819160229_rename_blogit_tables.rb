class RenameBlogitTables < ActiveRecord::Migration
  def change
    if table_exists?('blog_posts')
      rename_table('blog_posts', 'blogit_posts') 
    else
      report_missing_table("blog_posts")
    end
    
    if table_exists?('blog_comments')
      rename_table('blog_comments', 'blogit_comments')
    else
      report_missing_table("blog_posts")
    end  
  end
  
  private
  
  def report_missing_table(t_name)
    warn <<-WARNING
Table named: #{t_name} not found. Have you run the initial blogit migrations yet?
WARNING
  end
end
