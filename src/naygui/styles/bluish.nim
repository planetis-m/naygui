import std/paths
const rayguiDir = currentSourcePath().Path.parentDir / Path"../../raygui/styles/bluish"

{.passC: "-I" & rayguiDir.string.}

proc guiLoadStyleBluish*() {.importc: "GuiLoadStyleBluish", cdecl, header: "style_bluish.h".}
  ## Load style bluish over global style
