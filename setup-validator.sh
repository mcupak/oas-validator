#!/usr/bin/env bash

# This setup will not be needed once the online version of validator-badge supports OAS 3.0.
# Until then we'll need to set up a local version.

# use argument as the target directory for clone, default to validator-badge
TARGET=validator-badge
[[ -n  $1  ]] && TARGET=$1

# change directory instead of -f, otherwise validator-badge does not work correctly
( cd "$TARGET" && mvn package -q -DskipTests=true -Dmaven.javadoc.skip=true -B -V jetty:run & )
# wait for the app to start
sleep 45
