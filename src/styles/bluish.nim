import std/paths
const rayguiDir = currentSourcePath().Path.parentDir / Path"raygui/styles/bluish"

{.passC: "-I" & rayguiDir.}

type

type


{.push callconv: cdecl, header: "style_bluish.h".}
{.pop.}

proc guiLoadStyleBluish*() {.importc: "GuiLoadStyleBluish".}
  ## Load style bluish over global style
