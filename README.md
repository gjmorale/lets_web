# LET'S Web Application

This is the sample application for the LET'S WebApp based on tutorials from
- [*Ruby on Rails Tutorial:
Learn Web Development with Rails*](http://www.railstutorial.org/)
by [Michael Hartl](http://www.michaelhartl.com/).
- [*Existing Rails app to Docker*](http://chrisstump.online/2016/02/20/docker-existing-rails-application/).
- [*Docker compose rails tutorial*](https://docs.docker.com/compose/rails/).

## Getting started

First install Docker Engine and Docker Compose

Then, clone the repo and build the necesary images in the root directory with:

```
$ sudo docker-compose build
```

Then, start the containers with:

```
$ sudo docker-compose up
```

Next, create the postgres database:

```
$ sudo docker-compose run app rake db:create
```

For possible troubles with postgres gems do:

```
$ sudo apt-get install libpq-dev
$ sudo gem install pg
$ bundle update
```
