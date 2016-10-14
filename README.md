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

Run commands to the server as:

```
$ sudo docker-compose run app $COMMAND
```

##Troubleshooting

If the commands ran from inside the container do not allow write access grant them with:

```
$ sudo chown -R user:user $VOLUME_DIR
```

If server complains about other process running run

```
$ sudo rm lets/tmp/pids/server.pid
```

##Deployment

To deploy into Heroku
NOTICE: Actual branch will be uploaded, not master
INFO: heroku run rake db:migrate is optional but recommended

```
$ heroku maintenance:on
$ git subtree push --prefix heroku master
$ heroku run rake db:migrate
$ heroku maintenance:off
```

## GEMS:
- [Rut Validator](https://github.com/Phifo/rut_validation)
