#!/bin/bash

echo "Waiting for db..."
while ! nc -q0 db 5432; do sleep 1; done

echo "Running tests (mix test)..."
mix test
test_status=$?

echo "Checking code quality (mix credo)..."
mix credo
credo_status=$?

exit $(( test_status + credo_status ))
