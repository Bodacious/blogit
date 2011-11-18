# Blogit (beta)

This is a work in progress - you're welcome to start using it now though

## Installation

Add this to your Gemfile

``` ruby
gem "blogit"
```

...and run `bundle install` to install the gem.

Next, run:

``` bash
# add an initializer to config/initializers with all of the
# configuration options
$ rails g blogit:install
``` 

And finally

``` ruby
# This will add the necessary migrations to your app's db/migrate directory
rake blogit:install:migrations
# This will run any pending migrations
rake db:migrate
```

## Legal Stuff

Copyright 2011 Gavin Morrice

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


## Credits

Developed by [Bodacious (Gavin Morrice) @ Katana Code](http://gavinmorrice.com)