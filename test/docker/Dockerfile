FROM alpine:3.5

RUN apk add --no-cache \
      curl \
      net-tools

ENV APP_HOME=/usr/src/app/
WORKDIR $APP_HOME

COPY test.sh $APP_HOME/test.sh
COPY docker/start.sh $APP_HOME/start.sh
