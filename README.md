# OpenAPI Validator [![](https://travis-ci.org/mcupak/oas-validator.svg?branch=develop)](https://travis-ci.org/mcupak/oas-validator) [![](https://img.shields.io/badge/license-Apache%202-blue.svg)](https://raw.githubusercontent.com/mcupak/oas-validator/develop/LICENSE)

This repository contains a wrapper for [Swagger Validator Badge](https://github.com/swagger-api/validator-badge) suitable for validating [OpenAPI 3](https://github.com/OAI/OpenAPI-Specification) schemas as part of your CI build.

## Structure

This tool consists of 2 shell scripts:
- [setup-validator.sh](setup-validator.sh)
  - Downloads Swagger Validator Badge and starts a local instance of the validation server.
  - Only run this if you need to use a local validation server as opposed to a [public hosted version](http://validator.swagger.io/). Common reasons for doing this would include privacy concerns and access to the latest Swagger Validator Badge features not yet available on the hosted instance.
  - Usage:
    - `./setup-validator.sh [target] [branch]`
      - `[target]` - Target directory to store Swagger Validator Badge source in. Optional, defaults to `validator-badge`.
      - `[branch]` - Branch of [Swagger Validator Badge repository](https://github.com/swagger-api/validator-badge/) to use. Optional, defaults to `v.2.0.4` (latest at the time of writing this).
- [validate.sh](validate.sh)
  - Validates OAS specification at a given URL.
  - Usage:
    - `./validate.sh [url]`
      - `[url]` - URL to OAS specification to validate. Mandatory.
  - Configuration can be provided through following env vars:
    - `VALIDATOR_HOST` - Instance of Swagger Validator Badge to validate against. Optional, defaults to `https://validator.swagger.io`. When using a local validator instance set up through `setup-validator.sh`, set this to `http://localhost:8080`.
    - `VALIDATOR_TIMEOUT` - Timeout in seconds for busy waiting for Swagger Validator Badge to start. Optional, defaults to no timeout when using a remote validator and 60s when using a local validator. 

## Prerequisites

The following tools are needed to run the scripts:

- [git](https://git-scm.com/)
- [maven](https://maven.apache.org/)
- [java](https://openjdk.java.net/)
- [jq](https://stedolan.github.io/jq/)
- [curl](https://curl.haxx.se/)

You should run the following tools for testing when modifying this codebase, since they're run as part of the [CI build](.travis.yaml):

- [shellcheck](https://github.com/koalaman/shellcheck)

## Usage

As part of your Travis build, you want run the setup script in `before_install`, and run the validate script in your `script` section with the URL pointing to the specification file in your repository. The setup step will not be needed once the online version of Swagger Validator Badge supports OAS 3.

To have a stable build, you should clone a specific release (tag) of OAS Validator.

Here's a sample `.travis.yaml`:

```yaml
language: java
dist: bionic
sudo: false
jdk:
  - openjdk11
env:
  - GH_URL=https://raw.githubusercontent.com FILE_TO_VALIDATE=openapi.yaml URL_TO_VALIDATE=$GH_URL/${TRAVIS_PULL_REQUEST_SLUG:-$TRAVIS_REPO_SLUG}/${TRAVIS_PULL_REQUEST_BRANCH:-$TRAVIS_BRANCH}/$FILE_TO_VALIDATE
before_install:
  - git clone --branch=v1.0.0 https://github.com/mcupak/oas-validator.git
  - ./oas-validator/setup-validator.sh # only when needing a local validator
script:
  - ./oas-validator/validate.sh "$URL_TO_VALIDATE"
```
