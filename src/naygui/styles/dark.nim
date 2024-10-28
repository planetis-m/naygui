import std/paths
const rayguiDir = currentSourcePath().Path.parentDir / Path"../../raygui/styles/dark"

{.passC: "-I" & rayguiDir.string.}

proc guiLoadStyleDark*() {.importc: "GuiLoadStyleDark", cdecl, header: "style_dark.h".}
  ## Load style dark over global style
