import common

{.passC: "-I" & getRayguiStyleDir("cyber").}

proc guiLoadStyleCyber*() {.importc: "GuiLoadStyleCyber", cdecl, header: "style_cyber.h".}
  ## Load style cyber over global style
