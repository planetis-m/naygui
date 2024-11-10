import common

{.passC: "-I" & getRayguiStyleDir("lavanda").}

proc guiLoadStyleLavanda*() {.importc: "GuiLoadStyleLavanda", cdecl, header: "style_lavanda.h".}
  ## Load style lavanda over global style
