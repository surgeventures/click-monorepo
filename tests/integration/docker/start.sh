#!/bin/sh

echo "Waiting for click-client..."
while ! nc click-client 4100; do sleep 1; done

echo "Running tests (test.sh)..."
./test.sh
