[![Gem Version](https://badge.fury.io/rb/blogit.png)](http://badge.fury.io/rb/blogit)
[![Code Climate](https://codeclimate.com/github/KatanaCode/blogit.png)](http://codeclimate.com/github/KatanaCode/blogit/)
[![Test Coverage](https://d3s6mut3hikguw.cloudfront.net/github/KatanaCode/blogit/badges/coverage.svg)](http://codeclimate.com/github/KatanaCode/blogit/badges/)
[![Blogit](https://gemnasium.com/KatanaCode/blogit.png)](https://gemnasium.com/KatanaCode/blogit)
[![Travis CI](https://travis-ci.org/KatanaCode/blogit.png)](https://travis-ci.org/KatanaCode/blogit.png)

# Blogit - A Rails blogging solution

Blogit lets you add a blog to your Ruby on Rails application in just a few seconds.

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
rake acts\_as\_taggable\_on:install:migrations

# This will run any pending migrations
rake db:migrate

``` 

then add the following to your routes.rb file:

``` bash
# config/routes.rb
mount Blogit::Engine => "/blog"
```

Finally, declare which of your models acts as blogger in your app (probably User or Admin).

``` ruby
class User < ActiveRecord::Base
  
  blogs

end
```  

Go to http://localhost:3000/blog and see your marvelous new blog.


## Batteries included

Blogit provides you with the following features

* An XML Sitemap located at `/blog/posts.xml`
* An RSS feed located at `/blog/posts.rss`
* Internationalization (see the [locales file](config/locales/en.yml) for configurable options)
* Share links (Google+, Twitter & Facebook)
* [Disquss Comments](http://disqus.com)
* Code Syntax Highlighting CSS file (add `*= require pygments` to your app's stylesheet)
* CSS themes

## Documentation

Full documentation and how-to guides available here: http://blogit.katanacode.com

## Issues

If you discover a problem with Blogit, please let us know about it. 

**Remember** to search the [issues list](https://github.com/KatanaCode/blogit/issues) first in case your issue has already been raised
by another Githuber


## Contributing

Want to help make Blogit better?. Please read the [contribution guidelines](http://blogit.katanacode.com/doc/file.Contributing.html) for more information on how you can contribute.

## Legal Stuff

See [LEGAL][GithubLicence] for full details.

## Credits

Blogit was developed by [Katana Code](http://katanacode.com) with generous contributions from:

* [Juan Esparza](https://github.com/jjeb)
* [Philou](https://github.com/philou)
* [Stewart McKee](https://github.com/stewartmckee)
* [Karsten Silkenbäumer](https://github.com/kassi)

## About Katana Code

Katana Code are [web developers based in Edinburgh, Scotland](http://katanacode.com/ "Katana Code").

Copyright © 2011 - 2015 [Katana Code Ltd.](http://katanacode.com)

  [GithubLicence]: https://github.com/KatanaCode/blogit/blob/master/MIT-LICENSE