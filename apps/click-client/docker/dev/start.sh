#!/bin/bash

echo "Waiting for click-api..."
while ! nc -q0 click-api 4000; do sleep 1; done

echo "Starting the server (mix phx.server)..."
mix phx.server
