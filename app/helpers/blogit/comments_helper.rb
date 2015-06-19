module Blogit
  
  module CommentsHelper
    
    def name_for_comment(comment)
      if comment.website?
        link_to(comment.name, comment.website, class: "blogit_comment__name_link")
      else
        comment.name
      end + " " + t('wrote', scope: "blogit.comments")
    end
    
  end
end