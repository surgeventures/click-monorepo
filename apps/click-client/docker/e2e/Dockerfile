FROM elixir:1.5.1

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get update -qq && \
    apt-get install -y \
      build-essential \
      nodejs \
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

COPY assets/package.json $APP_HOME/assets/package.json
COPY assets/package-lock.json $APP_HOME/assets/package-lock.json
WORKDIR $APP_HOME/assets
RUN npm install

COPY assets $APP_HOME/assets
RUN node_modules/brunch/bin/brunch build --production

WORKDIR $APP_HOME
RUN mix phx.digest

EXPOSE 4100
