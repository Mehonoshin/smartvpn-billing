FROM ruby:2.1
MAINTAINER Stanislav Mekhonoshin <ejabberd@gmail.com>

ARG secret_token

RUN apt-get -y update
RUN apt-get -y install nodejs netcat

WORKDIR /app
COPY ./ .
ENV RAILS_ENV production
ENV SECRET_TOKEN=$secret_token

RUN gem install foreman
RUN bundle install
RUN cp config/database.yml.sample config/database.yml

RUN rake assets:precompile

CMD rm -f /app/tmp/pids/server.pid && rails db:migrate && foreman start -f Procfile
