import std/paths
const rayguiDir = currentSourcePath().Path.parentDir / Path"../../raygui/styles/amber"

{.passC: "-I" & rayguiDir.string.}

proc guiLoadStyleAmber*() {.importc: "GuiLoadStyleAmber", cdecl, header: "style_amber.h".}
  ## Load style amber over global style
