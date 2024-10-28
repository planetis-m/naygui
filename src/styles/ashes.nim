import std/paths
const rayguiDir = currentSourcePath().Path.parentDir / Path"raygui/styles/ashes"

{.passC: "-I" & rayguiDir.}

type

type


{.push callconv: cdecl, header: "style_ashes.h".}
{.pop.}

proc guiLoadStyleAshes*() {.importc: "GuiLoadStyleAshes".}
  ## Load style ashes over global style
