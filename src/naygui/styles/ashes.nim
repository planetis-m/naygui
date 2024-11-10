import common

{.passC: "-I" & getRayguiStyleDir("ashes").}

proc guiLoadStyleAshes*() {.importc: "GuiLoadStyleAshes", cdecl, header: "style_ashes.h".}
  ## Load style ashes over global style
