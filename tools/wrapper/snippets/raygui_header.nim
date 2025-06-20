from raylib import Vector2, Vector3, Color, Rectangle, Texture2D, Image, GlyphInfo, Font
export Vector2, Vector3, Color, Rectangle, Texture2D, Image, GlyphInfo, Font

import std/[assertions, paths]
from std/strutils import align
const rayguiDir = currentSourcePath().Path.parentDir / Path"raygui"

when defined(mingw):
  import std/private/globs
  from std/private/ospaths2 import joinPath
  func `/`(head, tail: Path): Path {.inline.} =
    joinPath(head.string, tail.string).nativeToUnixPath.Path
  {.passC: "-I/usr/x86_64-w64-mingw32/include".}

# {.passC: "-DRAYGUI_IMPLEMENTATION".}
{.passC: "-I" & rayguiDir.string.}
{.compile: string(rayguiDir / Path"raygui.c").}

const
  RayguiVersion* = (4, 5, 0)

type
  ConstCstringArray {.importc: "const char **".} = object

proc toConstCStringArray(x: cstringArray): ConstCstringArray {.
    importc: "(const char **)", noconv, nodecl.}
