# Package

version     = "4.0.0"
author      = "Antonis Geralis"
description = "Raygui Nim wrapper"
license     = "MIT"
srcDir      = "src"

# Deps

requires "nim >= 1.9.5"
requires "naylib >= 4.6.1"
#requires "eminim == 2.8.2"

#import std/distros
#foreignDep "wayland-protocols"
#foreignDep "wayland"

from std/os import `/`, quoteShell

const
  PkgDir = thisDir().quoteShell

before install:
  when defined(windows):
    let patchPath = PkgDir / "mangle_names.patch"
    withDir(PkgDir / "src/raygui"):
      exec "git apply " & patchPath
