import std/paths
const rayguiDir = currentSourcePath().Path.parentDir / Path"../../raygui/styles/lavanda"

{.passC: "-I" & rayguiDir.string.}

proc guiLoadStyleLavanda*() {.importc: "GuiLoadStyleLavanda", cdecl, header: "style_lavanda.h".}
  ## Load style lavanda over global style
