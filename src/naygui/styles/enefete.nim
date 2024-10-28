import std/paths
const rayguiDir = currentSourcePath().Path.parentDir / Path"../../raygui/styles/enefete"

{.passC: "-I" & rayguiDir.string.}

proc guiLoadStyleEnefete*() {.importc: "GuiLoadStyleEnefete", cdecl, header: "style_enefete.h".}
  ## Load style enefete over global style
