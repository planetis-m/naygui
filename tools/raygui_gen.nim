import common, std/[strutils, streams]
when defined(nimPreviewSlimSystem):
  import std/syncio

const
  rayguiHeader = """
from raylib import Vector2, Vector3, Color, Rectangle, Texture2D, Image, GlyphInfo, Font
export Vector2, Vector3, Color, Rectangle, Texture2D, Image, GlyphInfo, Font

import std/os
const rayguiDir = currentSourcePath().parentDir / "raygui/src"

{.passC: "-I" & rayguiDir.}
{.passC: "-DRAYGUI_IMPLEMENTATION".}

const
  RayguiVersion* = (4, 0, 0)
"""
  excludedTypes = [
    "Vector2",
    "Vector3",
    "Color",
    "Rectangle",
    "Texture2D",
    "Image",
    "GlyphInfo",
    "Font"
  ]

proc genBindings(t: TopLevel, fname: string, header, footer: string) =
  var buf = newStringOfCap(50)
  var indent = 0
  var otp: FileStream
  try:
    otp = openFileStream(fname, fmWrite)
    lit header
    # Generate enum definitions
    lit "\ntype"
    scope:
      for enm in items(t.enums):
        spaces
        var enmName = enm.name
        # if enmName notin ["GuiState", "GuiTextAlignment"]:
        #   removePrefix(enmName, "Gui")
        ident enmName
        lit "* {.size: sizeof(int32).} = enum"
        doc enm
        scope:
          var prev = -1
          for i, val in pairs(enm.values):
            if val.value == prev: continue
            spaces
            var valName = val.name
            removePrefix(valName, "STATE_")
            removePrefix(valName, "TEXT_ALIGN_")
            if startsWith(valName, "ICON_") and
                valName.len != 8 and not valName[^1].isDigit:
              removePrefix(valName, "ICON_")
            ident camelCaseAscii(valName)
            if prev + 1 != val.value:
              lit " = "
              lit $val.value
            doc val
            prev = val.value
          lit "\n"
    # Generate type definitions
    lit "\ntype"
    scope:
      for obj in items(t.structs):
        if obj.name in excludedTypes: continue
        spaces
        ident capitalizeAscii(obj.name)
        lit "* {.bycopy.} = object"
        doc obj
        scope:
          for fld in items(obj.fields):
            spaces
            var name = fld.name
            ident name
            lit "*: "
            # let kind = getReplacement(obj.name, name, replacement)
            # if kind != "":
            #   lit kind
            #   continue
            var baseKind = ""
            let kind = convertType(fld.`type`, "", false, false, false, baseKind)
            lit kind
            doc fld
        lit "\n"
    # Generate functions
    lit "\n{.push callconv: cdecl, header: \"raygui.h\".}"
    for fnc in items(t.functions):
      lit "\nproc "
      var name = fnc.name
      if name.endsWith("Pro") or name.endsWith("Ex"):
        removeSuffix(name, "Ex")
        removeSuffix(name, "Pro")
      # if name notin ["GuiEnable", "GuiDisable", "GuiLock", "GuiUnlock", "GuiIsLocked", "GuiFade"]:
      #   removePrefix(name, "Gui")
      ident uncapitalizeAscii(name)
      lit "*("
      var hasVarargs = false
      for i, param in fnc.params.pairs:
        if param.name == "args" and param.`type` == "...":
          hasVarargs = true
        else:
          if i > 0: lit ", "
          ident param.name
          lit ": "
          var baseKind = ""
          let kind = convertType(param.`type`, "", false, true, true, baseKind)
          lit kind
      lit ")"
      if fnc.returnType != "void":
        lit ": "
        var baseKind = ""
        let kind = convertType(fnc.returnType, "", false, false, true, baseKind)
        lit kind
      lit " {.importc: \""
      ident fnc.name
      lit "\""
      if hasVarargs:
        lit ", varargs"
      lit ".}"
      if fnc.description != "":
        scope:
          spaces
          lit "## "
          lit fnc.description
    lit "\n"
    lit footer
  finally:
    if otp != nil: otp.close()

const
  rayguiApi = "../api/raygui.json"
  outputname = "../src/raygui.nim"

proc main =
  var t = parseApi(rayguiApi)
  genBindings(t, outputname, rayguiHeader, "")

main()
