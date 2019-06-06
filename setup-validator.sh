#!/usr/bin/env bash

# use argument as the target directory for clone, default to validator-badge
TARGET=validator-badge
[[ -n  $1  ]] && TARGET=$1

# download validator badge
git clone -q --branch=v2.0.0 https://github.com/swagger-api/validator-badge.git "$TARGET"

# change directory instead of -f, otherwise validator-badge does not work correctly
( cd "$TARGET" && mvn package -q -DskipTests=true -Dmaven.javadoc.skip=true -B -V jetty:run & )

# wait for the app to start
sleep 45
