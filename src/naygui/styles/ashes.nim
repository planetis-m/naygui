import std/paths
const rayguiDir = currentSourcePath().Path.parentDir / Path"../../raygui/styles/ashes"

{.passC: "-I" & rayguiDir.string.}

proc guiLoadStyleAshes*() {.importc: "GuiLoadStyleAshes", cdecl, header: "style_ashes.h".}
  ## Load style ashes over global style
