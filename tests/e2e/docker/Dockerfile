FROM ruby:2.4.1

RUN apt-get update -qq && \
    apt-get install -y \
      netcat \
      build-essential

ENV APP_HOME=/usr/src/app/
WORKDIR $APP_HOME

RUN git clone --branch v0.3 https://github.com/surgeventures/docker-tools.git

COPY Gemfile* $APP_HOME
RUN bundle install

COPY lib $APP_HOME/lib
COPY test $APP_HOME/test
COPY Rakefile $APP_HOME/Rakefile
