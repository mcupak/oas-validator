# OpenAPI Validator [![](https://travis-ci.org/mcupak/oas-validator.svg?branch=develop)](https://travis-ci.org/mcupak/oas-validator) [![](https://img.shields.io/badge/license-Apache%202-blue.svg)](https://raw.githubusercontent.com/mcupak/oas-validator/develop/LICENSE)

This repository contains a wrapper for [Swagger Validator Badge](https://github.com/swagger-api/validator-badge) suitable for validating [OpenAPI 3](https://github.com/OAI/OpenAPI-Specification) schemas as part of your CI build.

## Structure

This tool consists of 3 shell scripts:
- [download-validator.sh](download-validator.sh)
  - Downloads validator (Swagger Validator Badge).
- [setup-validator.sh](setup-validator.sh)
  - Starts a local instance of the validator server.
- [validate.sh](validate.sh)
  - Validates a URL against the local validator server.

## Prerequisites

The following tools are needed to run the scripts:

- [git](https://git-scm.com/)
- [maven](https://maven.apache.org/)
- [java](https://openjdk.java.net/)
- [jq](https://stedolan.github.io/jq/)
- [curl](https://curl.haxx.se/)

You should run the following tools for testing when modifying this codebase, since they're run as part of the [CI build](.travis.yaml):

- [shellcheck](https://github.com/koalaman/shellcheck)

# Usage

As part of your Travis build, you want run the download and setup scripts in `before_install`, and run the validate script in your `script` section with the URL pointing to the specification file in your repository.

To have a stable build, you should clone a specific release (tag) of OAS Validator.

Here's a sample `.travis.yaml`:

```yaml
language: java
dist: trusty
sudo: false
jdk:
  - openjdk8
env:
  - GH_URL=https://raw.githubusercontent.com FILE_TO_VALIDATE=openapi.yaml URL_TO_VALIDATE=$GH_URL/${TRAVIS_PULL_REQUEST_SLUG:-$TRAVIS_REPO_SLUG}/${TRAVIS_PULL_REQUEST_BRANCH:-$TRAVIS_BRANCH}/$FILE_TO_VALIDATE
before_install:
  - git clone https://github.com/mcupak/oas-validator.git
  - ./oas-validator/download-validator.sh
  - ./oas-validator/setup-validator.sh
script:
  - ./oas-validator/validate.sh "$URL_TO_VALIDATE"
```
