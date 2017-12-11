FROM ruby:2.4.1
MAINTAINER diogonoda@hotmail.com

ENV RAILS_VERSION 5.1.4

# see update.sh for why all "apt-get install"s have to stay as one long line
RUN apt-get update \
 && apt-get install -y nodejs --no-install-recommends \
                       mysql-client \
                       postgresql-client \
                       sqlite3 --no-install-recommends \
 && rm -rf /var/lib/apt/lists/* \
 && mkdir -p /usr/src/app \
 && gem install rails --version "$RAILS_VERSION"

WORKDIR /usr/src/app

ADD Gemfile /usr/src/app/Gemfile
ADD Gemfile.lock /usr/src/app/Gemfile.lock

ADD . /usr/src/app
RUN bundle install --without production
