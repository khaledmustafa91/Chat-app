FROM ruby:2.7.5

ENV WAIT_VERSION 2.7.2

RUN apt-get update &&  apt-get install -y \
  build-essential \
  default-libmysqlclient-dev \
  imagemagick \
  git-core \
  && apt-get autoremove
ADD https://github.com/ufoscout/docker-compose-wait/releases/download/$WAIT_VERSION/wait /wait
RUN chmod +x /wait

RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV RAILS_ROOT /app
WORKDIR $RAILS_ROOT

COPY Gemfile Gemfile.lock ./
RUN gem install bundler -v 2.3.3
RUN bundle install --jobs 20 --retry 5

COPY . ./

ENTRYPOINT $RAILS_ROOT/docker/entrypoint.sh
