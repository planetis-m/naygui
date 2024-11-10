import common

{.passC: "-I" & getRayguiStyleDir("bluish").}

proc guiLoadStyleBluish*() {.importc: "GuiLoadStyleBluish", cdecl, header: "style_bluish.h".}
  ## Load style bluish over global style
