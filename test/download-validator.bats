@test "git clone" {
  run $BATS_TEST_DIRNAME/../download-validator.sh
  [ "$status" -eq 0 ]
  [ -d "validator-badge" ]
}
