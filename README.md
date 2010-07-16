# Merb iTunes Exercise

Coding exercise to retrieve data from iTunes API with a small Merb app

## Getting started

If you're using RVM, setup 1.8.7 with a fresh gemset.

    rvm use 1.8.7@itunes

Install the dependencies (merb installs rspec and datamapper, so no need 
to worry about those).

    gem install merb --version=1.0.15
    gem install do_mysql --version=0.10.2

Create config/database.yml (copy config/database.yml.example for a base version)

Install mongrel/thin/other to use as a webserver

    gem install mongrel
    or
    gem install thin

Fire up merb and point your browser to http://localhost:4000

    merb
    or
    merb -a thin

## Gotchas

Make sure you only have one version of json_pure installed, v1.2.0 
should be fine. Otherwise merb will load one version and dm-types 
etc will try and load a different one resulting in:

    FATAL: The gem dm-types (~> 0.10, runtime), [] was not found
    
## Running specs

The specs use webmock, so you'll need to install that before running the specs:

    gem install webmock
    
Once the dependencies are satisfied, run the specs with:

    rake spec