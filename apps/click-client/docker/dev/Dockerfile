FROM elixir:1.5.1

RUN apt-get update -qq && \
    apt-get install -y \
      netcat \
      build-essential \
      vim \
      git \
      libpq-dev \
      postgresql-client-9.4

ENV APP_HOME=/usr/src/app/
WORKDIR $APP_HOME

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

COPY docker/dev/start.sh $APP_HOME/start.sh
