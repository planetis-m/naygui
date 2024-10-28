from raylib import Vector2, Vector3, Color, Rectangle, Texture2D, Image, GlyphInfo, Font
export Vector2, Vector3, Color, Rectangle, Texture2D, Image, GlyphInfo, Font

import std/paths
const rayguiDir = currentSourcePath().Path.parentDir / Path"raygui/src"

{.passC: "-I" & rayguiDir.string.}
{.passC: "-DRAYGUI_IMPLEMENTATION".}

const
  RayguiVersion* = (4, 5, 0)
