import common

{.passC: "-I" & getRayguiStyleDir("cherry").}

proc guiLoadStyleCherry*() {.importc: "GuiLoadStyleCherry", cdecl, header: "style_cherry.h".}
  ## Load style cherry over global style
