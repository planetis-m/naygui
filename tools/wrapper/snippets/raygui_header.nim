from raylib import Vector2, Vector3, Color, Rectangle, Texture2D, Image, GlyphInfo, Font
export Vector2, Vector3, Color, Rectangle, Texture2D, Image, GlyphInfo, Font

import std/[assertions, paths]
from std/strutils import align
const rayguiDir = currentSourcePath().Path.parentDir / Path"raygui"

# {.passC: "-DRAYGUI_IMPLEMENTATION".}
{.passC: "-I" & rayguiDir.string.}
{.compile: rayguiDir / Path"raygui.c".}

const
  RayguiVersion* = (4, 5, 0)

type
  ConstCstringArray {.importc: "const char **".} = object

proc toConstCStringArray(x: cstringArray): ConstCstringArray {.
    importc: "(const char **)", noconv, nodecl.}
