## SmartVPN Billing

[![Build Status](https://travis-ci.org/Mehonoshin/smartvpn-billing.svg?branch=master)](https://travis-ci.org/Mehonoshin/smartvpn-billing)
[![](https://images.microbadger.com/badges/version/mexx/smartvpn-billing.svg)](https://hub.docker.com/r/mexx/smartvpn-billing)

<a href="https://imgbb.com/"><img src="https://image.ibb.co/gEVXM9/Screen-Shot-2018-10-14-at-18-34-17.png" alt="smartvpn-billing" border="0"></a>

Originally this project was a commercial VPN service for Russian segment of Internet.
Several years later when I got tired of endless support, I've decided to close my business and release the project to the opensource.

You can find some information about it at [https://news.ycombinator.com/item?id=9791633](https://news.ycombinator.com/item?id=9791633).

### Installation

All documentation is located in this repository: [https://github.com/Mehonoshin/smartvpn-docs](https://github.com/Mehonoshin/smartvpn-docs)

VPN node configuration is located in the following [repo](https://github.com/Mehonoshin/smartvpn-node).

### Set Up and Running app locally

1. Clone repo `git clone git@github.com:Mehonoshin/smartvpn-billing.git`
2. `cd smartvpn-billing`
3. `cp config/database.yml.sample config/database.yml` and enter the username and password for access to your database.
4. `cp .env.sample .env`
5. The file `.env` contains all the env variables used in the application.
6. `bundle install`
7. `rake db:setup`
8. `rails server`

### Start Up and Developing with Docker

1. Clone repo `git clone git@github.com:Mehonoshin/smartvpn-billing.git`
2. `cd smartvpn-billing`
3. `docker-compose -f docker-compose.development.yml build`
4. `docker-compose -f docker-compose.development.yml up`
5. Copy your `SECRET_TOKEN` to `.env`
6. Go to http://lvh.me:3000

*How to run usual RoR command into docker*
1. `docker-compose -f docker-compose.development.yml up`
2. `docker-compose exec app bash` - connect to running container as named app
3. `RAILS_ENV=test ./bin/rake db:setup` - setup test database
4. `./bin/rails console` - run rails console
5. `RAILS_ENV=test bundle exec rspec spec` - start rspec tests

How it works :)
https://www.youtube.com/watch?v=VFRKPO5LHDg

### Set Up and Running with Docker

For this type of installation we assume that you already have a VPS for billing with root access.
Also you should have `docker` and `docker-compose` installed on your machine.

For a successful project launch you also need to specify a list of environment variables on VPS, that will be ingested inside docker container.
Keep in mind, that these variables should be available each time you start/restart containers, so it is a good idea to keep them in `.bashrc`.

```
export SECRET_TOKEN=some_super_secret_value
```

Now you are ready to launch docker-compose. Feel free to copy it from repo directly to your VPS.

`docker-compose up -d`

Now the billing is ready and you can try to access it:

* Visit [http://vps_ip/admins/sign_in](http://vps_ip/admins/sign_in)
* Sign in with email `admin@smartvpn.biz` and password `password`

To accept the first users you need at least one tariff plan, that can be added at [http://vps_ip/admin/plans](http://vps_ip/admin/plans).

## Docker image

The docker image is built automatically on every merge to master. You can always pull the latest version of the image from Docker Hub.

```
docker pull mexx/smartvpn-billing
```

For more information about the builds visit docker hub page [mexx/smartvpn-billing](https://hub.docker.com/r/mexx/smartvpn-billing)


## Dockerization todo

* Document the list of ENV variables required for production
* Add simple nginx to proxy requests to the app
* Create VPN node image
* Add instructions how to run vpn on Digital Ocean
