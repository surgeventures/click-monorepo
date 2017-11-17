FROM elixir:1.5.1

RUN apt-get update -qq && \
    apt-get install -y \
      build-essential \
      ruby

ENV APP_HOME=/usr/src/app/
ENV MIX_ENV=prod
WORKDIR $APP_HOME

RUN git clone --branch v0.3 https://github.com/surgeventures/docker-tools.git

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

EXPOSE 4000
