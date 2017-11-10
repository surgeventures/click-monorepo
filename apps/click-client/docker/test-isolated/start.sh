#!/bin/bash

echo "Running tests (mix test)..."
mix test

echo "Checking code quality (mix credo)..."
mix credo
