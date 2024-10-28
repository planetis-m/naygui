# Package

version     = "4.5.0"
author      = "Antonis Geralis"
description = "Raygui Nim wrapper"
license     = "MIT"
srcDir      = "src"

# Deps

requires "nim >= 1.9.5"
requires "naylib >= 24.43"
#requires "eminim == 2.8.2"


task test, "Runs the test suite":
  exec "nim c -d:release tests/controls_test_suite.nim"
