FROM ruby:2.4.1

RUN apt-get update -qq && \
    apt-get install -y \
      netcat \
      build-essential

ENV APP_HOME=/usr/src/app/
WORKDIR $APP_HOME

COPY Gemfile* $APP_HOME
RUN bundle install

COPY lib $APP_HOME/lib
COPY test $APP_HOME/test
COPY Rakefile $APP_HOME/Rakefile

COPY docker/start.sh $APP_HOME/start.sh
