#!/bin/bash

echo "Running tests (mix test)..."
mix test
test_status=$?

echo "Checking code quality (mix credo)..."
mix credo
credo_status=$?

exit $(( test_status + credo_status ))
