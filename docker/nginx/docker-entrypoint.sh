#!/bin/sh

envsubst '$RAILS_ROOT' < /tmp/app.conf > /etc/nginx/conf.d/default.conf

exec "$@"
