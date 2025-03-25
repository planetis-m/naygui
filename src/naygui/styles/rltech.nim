import common

{.passC: "-I" & getRayguiStyleDir("rltech").}

proc guiLoadStyleRLtech*() {.importc: "GuiLoadStyleRltech", cdecl, header: "style_rltech.h".}
  ## Load style RLtech over global style
