# Blogit How-Tos

## Override a blogit controller action with your own controller

**Every blogit controller action** responds to being passed a block.

This makes it super-easy to subclass the controllers and add some of your own behaviour, keeping everything else just the way it is.


### Example: Updating :last\_viewed\_at when a Post is viewed

    class PostsController < Blogit::PostsController
      helper Blogit::Engine.routes.url_helpers
      def show
        super do |post|
          post.touch(:last_viewed_at)
        end
      end
      
    end

## Add syntax highlighting to code blocks

Blogit comes with a CSS file for instant code syntax highlighting. Simply include this file in your own CSS manifest file:

    /*
     *= require pygments
    */
