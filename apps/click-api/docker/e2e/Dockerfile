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
ENV MIX_ENV=prod
WORKDIR $APP_HOME

COPY mix* $APP_HOME
RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix deps.get --only prod

COPY config $APP_HOME/config
COPY docker/e2e/prod.exs $APP_HOME/config/prod.exs
RUN mix deps.compile

COPY lib $APP_HOME/lib
COPY priv $APP_HOME/priv
RUN mix compile

COPY docker/e2e/start.sh $APP_HOME/start.sh
EXPOSE 4000
