# OpenAPI Validator [![](https://travis-ci.org/mcupak/oas-validator.svg?branch=develop)](https://travis-ci.org/mcupak/oas-validator) [![](https://img.shields.io/badge/license-Apache%202-blue.svg)](https://raw.githubusercontent.com/mcupak/oas-validator/develop/LICENSE)

This repository contains a wrapper for [Swagger Validator Badge](https://github.com/swagger-api/validator-badge) suitable for validating [OpenAPI 3](https://github.com/OAI/OpenAPI-Specification) schemas as part of your CI build.

## Structure

This tool consists of 3 shell scripts:
- download.sh
    - Downloads Swagger Validator Badge tool.
- setup.sh
- validate.sh

## Prerequisites

The following tools are needed to run the scripts:

- git
- maven
- java
- sleep
- jq

The following tools are needed for development (testing):

- shellcheck
- bats

# Usage

```yaml
language: java
dist: trusty
sudo: false
jdk:
  - openjdk8
env:
  - GH_URL=https://raw.githubusercontent.com VALIDATOR_URL=http://localhost:8080/validator/debug?url FILE_TO_VALIDATE=service-info.yaml URL_TO_VALIDATE=$GH_URL/${TRAVIS_PULL_REQUEST_SLUG:-$TRAVIS_REPO_SLUG}/${TRAVIS_PULL_REQUEST_BRANCH:-$TRAVIS_BRANCH}/$FILE_TO_VALIDATE
before_install:
  # This setup will not be needed once the online version of validator-badge supports OAS 3.0. Until then we'll need to set up a local version.

  # build and start validator-badge
  - git clone --branch=v2.0.0 https://github.com/swagger-api/validator-badge.git
  - cd validator-badge
  - mvn package -q -DskipTests=true -Dmaven.javadoc.skip=true -B -V jetty:run &
  - cd ..
  - sleep 60
script:
```