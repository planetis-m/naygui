import std/paths
const rayguiDir = currentSourcePath().Path.parentDir / Path"raygui/styles/amber"

{.passC: "-I" & rayguiDir.}

type

type


{.push callconv: cdecl, header: "style_amber.h".}
{.pop.}

proc guiLoadStyleAmber*() {.importc: "GuiLoadStyleAmber".}
  ## Load style amber over global style
