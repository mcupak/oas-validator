@test "download swagger validator" {
  run $BATS_TEST_DIRNAME/../download-validator.sh
  [ "$status" -eq 0 ]
}
