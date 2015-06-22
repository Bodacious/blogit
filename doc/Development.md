# Blogit development notes

## To set up dummy app ...
    
    $ spring rake dummy:clean
    
    $ spring rake dummy:setup
    
    $ spring rake app:blogit:install:migrations
    
    $ spring rake db:migrate SCOPE=blogit

    
## To seed the database

    $ spring rake db:seed
    
## To run the tests

    $ spring rspec
    
    
## To start the dummy rails app server

    $ spring rails s