import common

{.passC: "-I" & getRayguiStyleDir("amber").}

proc guiLoadStyleAmber*() {.importc: "GuiLoadStyleAmber", cdecl, header: "style_amber.h".}
  ## Load style amber over global style
