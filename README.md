# LET'S Web Application

This is the sample application for the LET'S WebApp based on tutorials from
- [*Ruby on Rails Tutorial:
Learn Web Development with Rails*](http://www.railstutorial.org/)
by [Michael Hartl](http://www.michaelhartl.com/).
- [*Existing Rails app to Docker*](http://chrisstump.online/2016/02/20/docker-existing-rails-application/).
- [*Docker compose rails tutorial*](https://docs.docker.com/compose/rails/).

## Getting started

To get started with the app, clone the repo and then install the needed gems:

```
$ bundle install --without production
```

Next, migrate the database:

```
$ rails db:migrate
```

Finally, run the test suite to verify that everything is working correctly:

```
$ rails test
```

If the test suite passes, you'll be ready to run the app in a local server:

```
$ rails server
```

For more information, see the
[*Ruby on Rails Tutorial* book](http://www.railstutorial.org/book).