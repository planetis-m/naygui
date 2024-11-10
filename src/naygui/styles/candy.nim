import common

{.passC: "-I" & getRayguiStyleDir("candy").}

proc guiLoadStyleCandy*() {.importc: "GuiLoadStyleCandy", cdecl, header: "style_candy.h".}
  ## Load style candy over global style
