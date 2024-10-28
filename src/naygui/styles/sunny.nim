import std/paths
const rayguiDir = currentSourcePath().Path.parentDir / Path"../../raygui/styles/sunny"

{.passC: "-I" & rayguiDir.string.}

proc guiLoadStyleSunny*() {.importc: "GuiLoadStyleSunny", cdecl, header: "style_sunny.h".}
  ## Load style sunny over global style
