FROM ruby:2.5
LABEL Stanislav Mekhonoshin <ejabberd@gmail.com>

ARG secret_token
ENV SECRET_TOKEN=$secret_token

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get update && apt-get install -y --no-install-recommends \
  apt-utils \
  xvfb \
  libxi6 \
  libgconf-2-4 \
  netcat \
  wget \
  gcc \
  g++ \
  make \
  unzip \
  nodejs \
  openjdk-8-jre-headless

RUN curl -sS -o - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add \
  && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
  && apt-get -y update \
  && apt-get -y install google-chrome-stable \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

RUN wget -N http://chromedriver.storage.googleapis.com/$(curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE)/chromedriver_linux64.zip -P ~/ \
  && unzip ~/chromedriver_linux64.zip -d ~/ \
  && rm ~/chromedriver_linux64.zip \
  && mv -f ~/chromedriver /usr/local/bin/chromedriver \
  && chown root:root /usr/local/bin/chromedriver \
  && chmod 0755 /usr/local/bin/chromedriver

RUN wget -N http://selenium-release.storage.googleapis.com/3.9/selenium-server-standalone-3.9.0.jar -P ~/ \
  && mv -f ~/selenium-server-standalone-3.9.0.jar /usr/local/bin/selenium-server-standalone.jar \
  && chown root:root /usr/local/bin/selenium-server-standalone.jar \
  && chmod 0755 /usr/local/bin/selenium-server-standalone.jar

WORKDIR /app
COPY ./ .
RUN cp config/database.yml.sample config/database.yml

RUN gem install foreman
RUN bundle install -j 4

RUN rake assets:precompile
