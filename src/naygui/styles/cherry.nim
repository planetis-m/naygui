import std/paths
const rayguiDir = currentSourcePath().Path.parentDir / Path"../../raygui/styles/cherry"

{.passC: "-I" & rayguiDir.string.}

proc guiLoadStyleCherry*() {.importc: "GuiLoadStyleCherry", cdecl, header: "style_cherry.h".}
  ## Load style cherry over global style
