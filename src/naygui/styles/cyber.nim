import std/paths
const rayguiDir = currentSourcePath().Path.parentDir / Path"../../raygui/styles/cyber"

{.passC: "-I" & rayguiDir.string.}

proc guiLoadStyleCyber*() {.importc: "GuiLoadStyleCyber", cdecl, header: "style_cyber.h".}
  ## Load style cyber over global style
