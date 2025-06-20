import common

{.passC: "-I" & getRayguiStyleDir("genesis").}

proc guiLoadStyleGenesis*() {.importc: "GuiLoadStyleGenesis", cdecl, header: "style_genesis.h".}
  ## Load style Genesis over global style
