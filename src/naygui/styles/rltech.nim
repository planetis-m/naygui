import common

{.passC: "-I" & getRayguiStyleDir("rltech").}

proc guiLoadStyleRLtech*() {.importc: "GuiLoadStyleRLtech", cdecl, header: "style_rltech.h".}
  ## Load style RLtech over global style
