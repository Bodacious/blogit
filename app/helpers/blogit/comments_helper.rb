module Blogit
  module CommentsHelper
    # The commenter's name for a Comment. When the Comment has a website, includes an html
    # link containing their name. Otherwise, just shows the name as a String.
    #
    # comment - A {Blogit::Comment}
    #
    # Returns a String containing the commenter's name.
    def name_for_comment(comment)
      if comment.website?
        link_to(comment.name, comment.website, class: "blogit_comment__name_link")
      else
        comment.name
      end + " " + t("wrote", scope: "blogit.comments")
    end
  end
end
