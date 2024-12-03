import std/[os, strutils]

const
  ProjectUrl = "https://github.com/planetis-m/naygui"
  PkgDir = thisDir()
  RayguiDir = PkgDir / "raygui"
  RayguiGit = "https://github.com/raysan5/raygui.git"
  RayLatestCommit = "d0cbf9bee2f2226a00f1f86946187a29adc743d3"
  DocsDir = PkgDir / "docs"
  ToolsDir = PkgDir / "tools"
  ApiDir = ToolsDir / "wrapper/api"

template `/.`(x: string): string =
  when defined(posix): "./" & x else: x

proc fetchLatestRaylib() =
  var firstTime = false
  if not dirExists(RayguiDir):
    firstTime = true
    exec "git clone --depth 1 " & RayguiGit & " " & quoteShell(RayguiDir)
  withDir(RayguiDir):
    if not firstTime:
      exec "git switch - --detach"
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

proc genApiJson(lib, prefix, after: string) =
  withDir(ToolsDir / "parser"):
    mkDir(ApiDir)
    let header = RayguiDir / "src" / (lib & ".h")
    let apiJson = ApiDir / (lib & ".json")
    let prefixArg = if prefix != "": "-d " & prefix else: ""
    exec /.toExe("raylib_parser") & " -f JSON " & prefixArg & " -i " & header.quoteShell &
        " -t " & after.quoteShell & " -o " & apiJson.quoteShell

proc genWrapper(lib: string) =
  withDir(ToolsDir / "wrapper"):
    let outp = PkgDir / "src" / (lib & ".nim")
    let conf = "config" / (lib & ".cfg")
    exec /.toExe("naylib_wrapper") & " -c:" & conf & " -o:" & outp

proc wrapRaylib(lib, prefix, after: string) =
  genApiJson(lib, prefix, after)
  genWrapper(lib)

task buildTools, "Build raylib_parser and naylib_wrapper":
  buildParser()
  buildWrapper()
  buildMangler()

task genApi, "Generate API JSON files":
  buildParser()
  genApiJson("raygui", "RAYGUIAPI", "#endif // RAYGUI_H")

task genWrappers, "Generate Nim wrappers":
  genWrapper("raygui")

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
  wrapRaylib("raygui", "RAYGUIAPI", "#endif // RAYGUI_H")

task docs, "Generate documentation":
  withDir(PkgDir):
    for tmp in ["raygui"]:
      let doc = DocsDir / (tmp & ".html")
      let src = "src" / tmp
      exec "nim doc --verbosity:0 --git.url:" & ProjectUrl &
           " --git.devel:master --git.commit:master --out:" & doc.quoteShell & " " & src
