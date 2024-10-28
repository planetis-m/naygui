import std/paths
const rayguiDir = currentSourcePath().Path.parentDir / Path"../../raygui/styles/terminal"

{.passC: "-I" & rayguiDir.string.}

proc guiLoadStyleTerminal*() {.importc: "GuiLoadStyleTerminal", cdecl, header: "style_terminal.h".}
  ## Load style terminal over global style
