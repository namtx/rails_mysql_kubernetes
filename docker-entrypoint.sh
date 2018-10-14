#!/bin/sh

set -e

if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

echo "Waiting MySQL to start..."
while ! nc -z mysql 3306; do sleep 0.1; done
echo "MySQL is up"

echo "Waiting Redis to start..."
while ! nc -z redis 6379; do sleep 0.1; done
echo "Redis is up"

exec bundle exec "$@"
