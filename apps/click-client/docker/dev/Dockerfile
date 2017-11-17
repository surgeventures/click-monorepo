FROM elixir:1.5.1

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get update -qq && \
    apt-get install -y \
      build-essential \
      nodejs \
      ruby

ENV APP_HOME=/usr/src/app/
WORKDIR $APP_HOME

RUN git clone --branch v0.3 https://github.com/surgeventures/docker-tools.git

COPY mix* $APP_HOME
RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix deps.get

COPY config $APP_HOME/config
COPY docker/dev/dev.local.exs $APP_HOME/config/dev.local.exs
RUN mix deps.compile

COPY lib $APP_HOME/lib
COPY priv $APP_HOME/priv
RUN mix compile

COPY assets $APP_HOME/assets
RUN cd assets && npm install
