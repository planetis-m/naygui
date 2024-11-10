import common

{.passC: "-I" & getRayguiStyleDir("jungle").}

proc guiLoadStyleJungle*() {.importc: "GuiLoadStyleJungle", cdecl, header: "style_jungle.h".}
  ## Load style jungle over global style
