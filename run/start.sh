#!/usr/bin/env bash
echo -e "Start script" \
&& cd /home/node/app/public \
&& ls -al \
&& chmod +x env.sh \
&& exec ./env.sh \