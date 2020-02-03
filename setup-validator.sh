#!/usr/bin/env bash

# use arguments as the target directory and branch for clone, default to validator-badge and latest release at this time, respectively
TARGET=validator-badge
[[ -n  $1  ]] && TARGET=$1
BRANCH=v2.0.4
[[ -n  $2  ]] && BRANCH=$2

# download validator badge
git clone -q --branch="$BRANCH" https://github.com/swagger-api/validator-badge.git "$TARGET"

# change directory instead of -f, otherwise validator-badge does not work correctly, and start the validator server
( cd "$TARGET" && mvn package -q -DskipTests=true -Dmaven.javadoc.skip=true -B -V jetty:run & )
