FROM ruby:2.5.1

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
  apt-get update -qq && \
  apt-get install -y build-essential \
  default-libmysqlclient-dev \
  nodejs \
  qt5-default \
  libqt5webkit5-dev \
  gstreamer1.0-plugins-base \
  gstreamer1.0-tools \
  gstreamer1.0-x \
  mysql-client \
  xvfb \
  imagemagick \
  redis-tools && \
  apt-get clean && \
  npm install -g gulp-cli \
  bower \
  eslint \
  babel-eslint \
  eslint-plugin-angular && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  lsof \
  vim

RUN apt-get update -qq && \
  apt-get install -y netcat-openbsd

RUN mkdir /rails_app
WORKDIR /rails_app

ADD Gemfile /rails_app/Gemfile
ADD Gemfile.lock /rails_app/Gemfile.lock

RUN bundle install

ADD . /rails_app

COPY docker-entrypoint.sh /usr/local/bin

ENTRYPOINT [ "docker-entrypoint.sh" ]

