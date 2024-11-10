import common

{.passC: "-I" & getRayguiStyleDir("terminal").}

proc guiLoadStyleTerminal*() {.importc: "GuiLoadStyleTerminal", cdecl, header: "style_terminal.h".}
  ## Load style terminal over global style
