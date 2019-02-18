## SmartVPN Billing

[![Build Status](https://travis-ci.org/Mehonoshin/smartvpn-billing.svg?branch=master)](https://travis-ci.org/Mehonoshin/smartvpn-billing)
[![](https://images.microbadger.com/badges/version/mexx/smartvpn-billing.svg)](https://hub.docker.com/r/mexx/smartvpn-billing)

<a href="https://imgbb.com/"><img src="https://image.ibb.co/gEVXM9/Screen-Shot-2018-10-14-at-18-34-17.png" alt="smartvpn-billing" border="0"></a>

Originally this project was a commercial VPN service for Russian segment of Internet.
Several years later when I got tired of endless support, I've decided to close my business and release the project to the opensource.

You can find some information about it at [https://news.ycombinator.com/item?id=9791633](https://news.ycombinator.com/item?id=9791633).

### Installation

All documentation is located in this repository: [https://github.com/Mehonoshin/smartvpn](https://github.com/Mehonoshin/smartvpn)

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
3. `docker-compose -f docker-compose.development.yml up`
4. Copy your `SECRET_TOKEN` to `.env`
5. Go to http://lvh.me:3000

*How to run usual RoR command into docker*
1. `docker-compose -f docker-compose.development.yml up`
2. `docker-compose exec app bash` - connect to running container as named app
3. `RAILS_ENV=test ./bin/rake db:setup` - setup test database
4. `./bin/rails console` - run rails console
5. `RAILS_ENV=test bundle exec rspec spec` - start rspec tests

How it works :)
https://www.youtube.com/watch?v=VFRKPO5LHDg

## Docker image

The docker image is built automatically on every merge to master. You can always pull the latest version of the image from Docker Hub.

```
docker pull mexx/smartvpn-billing
```

For more information about the builds visit docker hub page [mexx/smartvpn-billing](https://hub.docker.com/r/mexx/smartvpn-billing)
