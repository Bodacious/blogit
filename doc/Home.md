[![Gem Version](https://badge.fury.io/rb/blogit.png)](http://badge.fury.io/rb/blogit)
[![Code Climate](https://codeclimate.com/github/KatanaCode/blogit.png)](http://codeclimate.com/github/KatanaCode/blogit/)
[![Blogit](https://gemnasium.com/KatanaCode/blogit.png)](https://gemnasium.com/KatanaCode/blogit)
[![Travis CI](https://travis-ci.org/KatanaCode/blogit.png)](https://travis-ci.org/KatanaCode/blogit.png)



# Blogit - Add a blog to your Rails application in seconds

Blogit lets you add a blog to your Ruby on Rails application in just a few seconds.

We developed blogit because we found ourselves adding the same features to client apps over and over again. Now blogit handles all of that for us.

## Installation

Add these to your Gemfile

``` ruby
gem "blogit"
# Blogit depends on ActsAsTaggableOn
gem "acts-as-taggable-on"
```

...and run `bundle install` to install the gem.

Next, run:

``` bash
# add an initializer to config/initializers with all of the configuration options
$ rails g blogit:install

# This will add the necessary migrations to your app's db/migrate directory
rake blogit:install:migrations

# You don't need to run again this if you've already done so
rake acts_as_taggable_on:install:migrations

# This will run any pending migrations
rake db:migrate

``` 

then add the following to your routes.rb file:

``` bash
# config/routes.rb
mount Blogit::Engine => "/blog"
```

Finally, declare which of your models acts as blogger in your app (probably User or Admin) by calling the `blogs` method in your model.

``` ruby
class User < ActiveRecord::Base
  
  blogs

end
```  

Go to http://localhost:3000/blog and see your marvelous new blog.

## Instant gratification

We've added some rake tasks to make development easier. 

### Seed blog posts

This rake task will add a bunch of blog posts to your DB:

``` bash
rake blogit:seed
```

Make sure you have at least one model defined as a blogger (probably User or Admin)

### CSS Themes

Too lazy to write your own CSS? Load in one of blogit's themes.

``` css
/*
 *= require blogit/themes/[theme-name]
*/
```

The list of themes currently available:

* default

## Configuration

Running `rails g blogit:install` will add an initializer file named `config/initializers/blogit.rb`. Here you can set various configuration options. 

Please {Blogit::Configuration read the configuration docs} for a full list of the options available.

## How to

There's a ton of stuff you can do with Blogit. Please read the {file:HowTo.md How To Guide} for more information.

## Batteries included

Blogit provides you with the following features

* An XML Sitemap located at `/blog/posts.xml`
* An RSS feed located at `/blog/posts.rss`
* Internationalization (see the locales files for configurable options)
* Share links (Google+, Twitter & Facebook)
* [Disquss Comments](http://disqus.com)
* Code Syntax Highlighting CSS file (add `*= require pygments` to your app's stylesheet)
* CSS Themes

## Features we've still to add

Blogit is still undergoing development. We're always looking for ways to make it better.

Read the {file:TODOs.md} page for a list of the features we'd like to support.

## Upgrading from a previous version?

If you're upgrading from a beta version of blogit, please read [this upgrade guide](http://blogit.katanacode.com/doc/file.Upgrading.html)

## Issues

If you discover a problem with Blogit, please let us know about it. 

**Remember** to search the [issues list](https://github.com/KatanaCode/blogit/issues) first in case your issue has already been raised
by another Githuber


## Contributing

Want to help make Blogit better?. Please read the [contribution guidelines](http://blogit.katanacode.com/doc/file.Contributing.html) for more information on how you can contribute.

## Legal Stuff

Blogit is realeased under the MIT License.

See [LEGAL][GithubLicence] for full details.

## Credits

Blogit was developed by [Katana Code](http://katanacode.com) with generous contributions from:

* [Philou][Philou]
* [Stewart McKee][StewartMcKee]
* [Karsten Silkenbäumer][KarstenSilkenbaumer]

## About Katana Code

Katana Code are [web developers based in Edinburgh, Scotland](http://katanacode.com/ "Katana Code").

Copyright © 2011 - 2015 [Katana Code Ltd.](http://katanacode.com)
  
  [KarstenSilkenbaumer]:https://github.com/kassi
  [StewartMcKee]: https://github.com/stewartmckee
  [Philou]: https://github.com/philou
  [GithubLicence]: https://github.com/KatanaCode/blogit/blob/master/MIT-LICENSE