#!/bin/bash

# Recreate config file
rm -rf ./env-config.js
touch ./env-config.js

# create .env
printenv >> .env

# Add assignment 
echo "window._env_ = {" >> ./env-config.js

# Read each line in .env file
# Each line represents key=value pairs
while read -r line ;
do
  # Split env variables by character `=`
  if printf '%s\n' "$line" | grep -q -e '='; then
    varname=$(printf '%s\n' "$line" | sed -e 's/=.*//')
    varvalue=$(printf '%s\n' "$line" | sed -e 's/^[^=]*=//')
  fi
  
  # Append configuration property to JS file
  echo "  $varname: \"$varvalue\"," >> ./env-config.js
done < .env

echo "}" >> ./env-config.js