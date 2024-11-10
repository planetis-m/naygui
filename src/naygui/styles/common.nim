import std/paths

proc getRayguiStyleDir*(styleName: string): string =
  `$`(currentSourcePath().Path.parentDir / Path"../../raygui/styles" / Path(styleName))
