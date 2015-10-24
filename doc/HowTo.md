# Blogit How-Tos

## Override a blogit controller action with your own controller

**Every blogit controller action** responds to being passed a block.

This makes it super-easy to subclass the controllers and add some of your own behaviour, keeping everything else just the way it is.


### Example: Updating :last\_viewed\_at when a Post is viewed

    class PostsController < Blogit::PostsController
    
      def show
        super do |post|
          post.touch(:last_viewed_at)
        end
      end
      
    end

## Add a CSS theme to your application

We're starting to support out-of-the box themes for blogit to make it even easier for you to get started.

### Installing a theme

Themes are bundled into the app as CSS/SASS files. To include one, simply add the following to your CSS manifest file:

    /* application.css */
    @import "blogit/themes/[theme name]"
    
You can browse the currently available list of themes here:

https://github.com/KatanaCode/blogit/tree/master/app/assets/stylesheets/blogit/themes

### Adding your own theme

We'd really appreciate if developers want to add their own theme to blogit. To do so, 
create a new directory withing the [themes directory](https://github.com/KatanaCode/blogit/tree/master/app/assets/stylesheets/blogit/themes) 
and structure it like so:

    ./your_theme.sass
    ./your_theme
      /base   # variables for colours, fonts, etc. and general HTML styles go in here
      /blocks # Define BEM-style CSS blocks in here
      
Once your happy with the theme, submit a pull-request to request a merge with master. For 
more information, please read the {file:Contributing.md Contribution} guidelines.