import common

{.passC: "-I" & getRayguiStyleDir("enefete").}

proc guiLoadStyleEnefete*() {.importc: "GuiLoadStyleEnefete", cdecl, header: "style_enefete.h".}
  ## Load style enefete over global style
