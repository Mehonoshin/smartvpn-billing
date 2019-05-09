FROM ruby:2.6.3
LABEL Stanislav Mekhonoshin <ejabberd@gmail.com>

ARG secret_token

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get update && apt-get install -y --no-install-recommends \
  nodejs \
  netcat

WORKDIR /app
COPY ./ .
ENV RAILS_ENV production
ENV SECRET_TOKEN=$secret_token

RUN gem install foreman
RUN bundle install
RUN cp config/database.yml.sample config/database.yml

RUN rake assets:precompile

CMD rm -f /app/tmp/pids/server.pid && rails db:migrate && foreman start -f Procfile
