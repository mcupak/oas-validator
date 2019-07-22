#!/usr/bin/env bash

VALIDATOR_URL="http://localhost:8080/validator/debug?url"
# use the first argument as the URL to a file to validate
URL_TO_VALIDATE="$1"
# use timeout from environment variable (optional)
TIMEOUT=60
[[ -n "$VALIDATOR_TIMEOUT" ]] && TIMEOUT=${VALIDATOR_TIMEOUT}

# wait for the server to start
for ((i = 1; i <= TIMEOUT; i++)); do
  if curl -sS "$VALIDATOR_URL" 2> /dev/null; then break; fi
  sleep 1
done

# validate
echo "Validating $URL_TO_VALIDATE:"
VALIDATION_OUTPUT=$(curl -sS "$VALIDATOR_URL=$URL_TO_VALIDATE")

# print validation errors
echo "$VALIDATION_OUTPUT"

# check if the validation output ignoring warnings is an empty array
VALIDATION_ERROR_COUNT=$(echo "$VALIDATION_OUTPUT" |jq -c '.schemaValidationMessages // [] | map(select(.level != "warning"))' |jq length)
test "$VALIDATION_ERROR_COUNT" == 0
