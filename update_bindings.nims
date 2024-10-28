import std/[os, strutils]

const
  ProjectUrl = "https://github.com/planetis-m/naygui"
  PkgDir = thisDir()
  RayguiDir = PkgDir / "raygui"
  RayguiGit = "https://github.com/raysan5/raygui.git"
  RayLatestCommit = "1e03efca48c50c5ea4b4a053d5bf04bad58d3e43"
  DocsDir = PkgDir / "docs"
  ToolsDir = PkgDir / "tools"
  ApiDir = ToolsDir / "wrapper/api"

template `/.`(x: string): string =
  when defined(posix): "./" & x else: x

proc fetchLatestRaylib() =
  if not dirExists(RayguiDir):
    exec "git clone --depth 1 " & RayguiGit & " " & quoteShell(RayguiDir)
  withDir(RayguiDir):
    exec "git switch -"
    exec "git fetch --depth 100 origin " & RayLatestCommit
    exec "git checkout " & RayLatestCommit

proc buildParser() =
  withDir(ToolsDir / "parser"):
    let src = "raylib_parser.c"
    let exe = toExe("raylib_parser")
    # if not fileExists(exe) or fileNewer(src, exe):
    exec "cc " & src & " -o " & exe

proc buildMangler() =
  withDir(ToolsDir / "mangler"):
    let src = "naylib_mangler.nim"
    let exe = toExe("naylib_mangler")
    # if not fileExists(exe) or fileNewer(src, exe):
    exec "nim c --mm:arc --panics:on -d:release " & src

proc buildWrapper() =
  withDir(ToolsDir / "wrapper"):
    let src = "naylib_wrapper.nim"
    let exe = toExe("naylib_wrapper")
    # if not fileExists(exe) or fileNewer(src, exe):
    exec "nim c --mm:arc --panics:on -d:release -d:emiLenient " & src

proc genApiJson(lib, prefix, after, headerPath: string) =
  withDir(ToolsDir / "parser"):
    mkDir(ApiDir)
    let header = RayguiDir / headerPath / (lib & ".h")
    let apiJson = ApiDir / (lib & ".json")
    let prefixArg = if prefix != "": "-d " & prefix else: ""
    exec /.toExe("raylib_parser") & " -f JSON " & prefixArg & " -i " & header.quoteShell &
        " -t " & after.quoteShell & " -o " & apiJson.quoteShell

proc genWrapper(lib, outputPath: string) =
  withDir(ToolsDir / "wrapper"):
    let outp = PkgDir / "src" / (outputPath & ".nim")
    let conf = "config" / (lib & ".cfg")
    exec /.toExe("naylib_wrapper") & " -c:" & conf & " -o:" & outp

proc wrapRaylib(lib, prefix, after, headerPath, outputPath: string) =
  genApiJson(lib, prefix, after, headerPath)
  genWrapper(lib, outputPath)

task buildTools, "Build raylib_parser and naylib_wrapper":
  buildParser()
  buildWrapper()
  buildMangler()

let styles =
  ["amber", "ashes", "bluish", "candy", "cherry", "cyber", "dark",
   "enefete", "jungle", "lavanda", "sunny", "terminal"]

task genApi, "Generate API JSON files":
  buildParser()
  genApiJson("raygui", "RAYGUIAPI", "#endif // RAYGUI_H", "src")
  for style in styles.items:
    genApiJson("style_" & style, "", "", "styles" / style)

task genWrappers, "Generate Nim wrappers":
  genWrapper("raygui", "raygui")
  for style in styles.items:
    genWrapper("style_" & style, "styles" / style)

task update, "Update the raygui git directory":
  fetchLatestRaylib()
  rmDir(PkgDir / "src/raygui")
  cpDir(RayguiDir / "src", PkgDir / "src/raygui")
  cpDir(RayguiDir / "styles", PkgDir / "src/raygui/styles")

task mangle, "Mangle identifiers in raygui source":
  buildMangler()
  withDir(ToolsDir / "mangler"):
    exec /.toExe("naylib_mangler") & " " & (PkgDir / "src/raygui")

task wrap, "Produce all raygui Nim wrappers":
  buildToolsTask()
  wrapRaylib("raygui", "RAYGUIAPI", "#endif // RAYGUI_H", "src", "raygui")
  for style in styles.items:
    wrapRaylib("style_" & style, "", "", "styles" / style, "styles" / style)

task docs, "Generate documentation":
  withDir(PkgDir):
    for tmp in ["raygui"]:
      let doc = DocsDir / (tmp & ".html")
      let src = "src" / tmp
      let showNonExports = if tmp != "rmem": " --shownonexports" else: ""
      exec "nim doc --verbosity:0 --git.url:" & ProjectUrl & showNonExports &
           " --git.devel:main --git.commit:main --out:" & doc.quoteShell & " " & src
