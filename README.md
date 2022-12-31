[![Gem Version](https://badge.fury.io/rb/blogit.png)](http://badge.fury.io/rb/blogit)
[![Code Climate](https://codeclimate.com/github/KatanaCode/blogit.png)](http://codeclimate.com/github/KatanaCode/blogit/)
[![Test Coverage](https://d3s6mut3hikguw.cloudfront.net/github/KatanaCode/blogit/badges/coverage.svg)](http://codeclimate.com/github/KatanaCode/blogit/badges/)
[![Blogit](https://gemnasium.com/KatanaCode/blogit.png)](https://gemnasium.com/KatanaCode/blogit)
[![Travis CI](https://travis-ci.org/KatanaCode/blogit.png)](https://travis-ci.org/KatanaCode/blogit.png)
[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/Bodacious/blogit/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

# Blogit - A Rails blogging solution

Blogit lets you add a blog to your Ruby on Rails application in just a few seconds.

_NOTE: Blogit is currently dormant. I'm interested in spending some time to release version 2.0 for modern Rails environments, but development is going slowly due to very limiting time constraints._. If you're interested in helping to update for version 2.0, please get in touch.

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

# You don't need to run this again if you've already done so
rake acts_as_taggable_on_engine:install:migrations

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

## Modular

We're designing blogit to be as modular as possible, so you can pick and choose the elements you'd like to use.

* For **Admin CMS** please install [blogit-admin](https://github.com/bodacious/blogit-admin)

## Documentation

Full documentation and how-to guides available here: https://bodacious.github.io/blogit

## Issues

If you discover a problem with Blogit, please report it via the Issues tab on Github. 

**Remember** to search the [issues list](https://github.com/bodacious/blogit/issues) first in case your issue has already been raised
by another Githuber


## Contributing

Want to help make Blogit better?. Please read the [contribution guidelines](http://bodacious.github.io/blogit/doc/file.Contributing.html) for more information on how you can contribute.

## Legal Stuff

See [LEGAL][GithubLicence] for full details.

## Credits

Blogit was developed by [Katana Code](http://katanacode.com) with generous contributions from:

* [Juan Esparza](https://github.com/jjeb)
* [Philou](https://github.com/philou)
* [Stewart McKee](https://github.com/stewartmckee)
* [Karsten Silkenbäumer](https://github.com/kassi)

Blogit is currently owned and maintained by [@bodacious](https://github.com/bodacious)

[GithubLicence]: https://github.com/bodacious/blogit/blob/master/MIT-LICENSE
