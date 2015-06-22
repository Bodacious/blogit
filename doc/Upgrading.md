# Upgrading blogit from a previous beta version

Blogit evolved a lot before version 1.0.0 and if you're upgrading from a previous version there are a lot of breaking changes.


## Upgrade checklist 

To make sure your application is up-to-date, check the following:

### Does your DB have the correct tables?

Make sure your database has the following tables and columns

```
create_table "blogit_comments", force: :cascade do |t|
  t.string   "name",       null: false
  t.string   "email",      null: false
  t.string   "website"
  t.text     "body",       null: false
  t.integer  "post_id",    null: false
  t.string   "state"
  t.datetime "created_at"
  t.datetime "updated_at"
end

add_index "blogit_comments", ["post_id"], name: "index_blogit_comments_on_post_id"

create_table "blogit_posts", force: :cascade do |t|
  t.string   "title",                            null: false
  t.text     "body",                             null: false
  t.string   "state",          default: "draft", null: false
  t.integer  "comments_count", default: 0,       null: false
  t.integer  "blogger_id"
  t.string   "blogger_type"
  t.datetime "created_at"
  t.datetime "updated_at"
  t.text     "description"
end

add_index "blogit_posts", ["blogger_type", "blogger_id"], name: "index_blogit_posts_on_blogger_type_and_blogger_id"

create_table "taggings", force: :cascade do |t|
  t.integer  "tag_id"
  t.integer  "taggable_id"
  t.string   "taggable_type"
  t.integer  "tagger_id"
  t.string   "tagger_type"
  t.string   "context",       limit: 128
  t.datetime "created_at"
end

add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"

create_table "tags", force: :cascade do |t|
  t.string  "name"
  t.integer "taggings_count", default: 0
end
```

### Do you have a Blogger class?

Make sure you have at least one `ActiveRecord::Base` subclass model that calls the `blogs` macro.

``` ruby
class Admin < ActiveRecord::Base

  blogs
  
end
```

### Do you need to install [blogit-admin](//github.com/katanacode/blogit-admin)?

We've stripped the blogit admin features into its own gem. If you were previously relying on Blogit to provide the actions for creating and editing blog posts, consider installing [blogit-admin](//github.com/katanacode/blogit-admin) instead.

### Do you need to update your CSS classes?

We updated blogit to use [BEM](//getbem.com/introduction/) classes for our HTML and CSS. While this is quite a disruptive change, we believe that this will help us keep blogit clean and easier to maintain over time.

Have a look at the [HTML templates][BlogitHTML] and [CSS files][BlogitCSS] to see how the classes are different now.

### Does your initializer have the correct attributes?

We've changed a couple of the settings in the {Blogit::Configuration} class. Make sure your `config/initializers/blogit.rb` file still makes sense with the new version.

You can read more about the configuration options {Blogit::Configuration here}.

### Still stuck? Ask...

If you're still stuck, please [open a new issue on GitHub][BlogitGithub] and we'll help you out as soon as we can.


---

Back to {file:Home.md}

  [BlogitHTML]: https://github.com/KatanaCode/blogit/tree/master/app/views/blogit
  [BlogitCSS]: https://github.com/KatanaCode/blogit/tree/master/app/assets/stylesheets/blogit/themes
  [BlogitGithub]: http://github.com/KatanaCode/blogit
