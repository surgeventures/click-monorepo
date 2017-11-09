#!/bin/bash

echo "Waiting for db..."
while ! nc -q0 db 5432; do sleep 1; done

echo "Starting development server (mix phx.server)..."
mix phx.server
