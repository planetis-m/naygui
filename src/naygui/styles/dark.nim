import common

{.passC: "-I" & getRayguiStyleDir("dark").}

proc guiLoadStyleDark*() {.importc: "GuiLoadStyleDark", cdecl, header: "style_dark.h".}
  ## Load style dark over global style
