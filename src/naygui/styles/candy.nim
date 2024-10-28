import std/paths
const rayguiDir = currentSourcePath().Path.parentDir / Path"../../raygui/styles/candy"

{.passC: "-I" & rayguiDir.string.}

proc guiLoadStyleCandy*() {.importc: "GuiLoadStyleCandy", cdecl, header: "style_candy.h".}
  ## Load style candy over global style
