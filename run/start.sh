#!/usr/bin/env bash
cd /react_app \
&& chmod +x env.sh \
&& exec ./env.sh \
&& exec /usr/bin/supervisord -c /run/supervisord.conf