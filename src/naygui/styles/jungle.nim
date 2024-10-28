import std/paths
const rayguiDir = currentSourcePath().Path.parentDir / Path"../../raygui/styles/jungle"

{.passC: "-I" & rayguiDir.string.}

proc guiLoadStyleJungle*() {.importc: "GuiLoadStyleJungle", cdecl, header: "style_jungle.h".}
  ## Load style jungle over global style
