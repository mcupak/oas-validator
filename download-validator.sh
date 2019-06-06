#!/usr/bin/env bash

# use argument as the target directory for clone, default to validator-badge
TARGET=validator-badge
[[ -n  $1  ]] && TARGET=$1

# clone validator batch
git clone --branch=v2.0.0 https://github.com/swagger-api/validator-badge.git "$TARGET"
