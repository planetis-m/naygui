import common

{.passC: "-I" & getRayguiStyleDir("sunny").}

proc guiLoadStyleSunny*() {.importc: "GuiLoadStyleSunny", cdecl, header: "style_sunny.h".}
  ## Load style sunny over global style
