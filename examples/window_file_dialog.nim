import std/[os, times, strutils, private/ospaths2], raylib, raygui

type
# when defined(UseCustomListViewFileInfo):
  FileInfo = object
    name: string
    size: int64
    modTime: int64
    fileType: int32
    icon: GuiIconName

  GuiWindowFileDialogState = object # Gui file dialog context data
    # Window management variables
    windowActive: bool
    windowBounds: Rectangle
    panOffset: Vector2
    dragMode: bool
    supportDrag: bool

    # UI variables
    dirPathEditMode: bool
    dirPathText: string
    filesListScrollIndex: int32
    filesListEditMode: bool
    filesListActive: int32
    fileNameEditMode: bool
    fileNameText: string
    selectFilePressed: bool
    cancelFilePressed: bool
    fileTypeActive: int32
    itemFocused: int32

    # Custom state variables
    dirFiles: seq[string]
    filterExt: string
    prevFilesListActive: int32
    saveFileMode: bool

  # Gui control property style color element
  GuiPropertyElement = enum
    Border = 0,
    Base,
    Text,
    Other

const
  MaxDirectoryFiles = 2048
  MaxIconPathLength = 512

var dirFilesIcon: seq[FileInfo]

proc initGuiWindowFileDialog*(initPath: string): GuiWindowFileDialogState =
  result = GuiWindowFileDialogState()

  # Init window data
  result.windowBounds = Rectangle(
    x: (getScreenWidth().float32 / 2) - (440 / 2),
    y: (getScreenHeight().float32 / 2) - (310 / 2),
    width: 440,
    height: 310
  )

  result.windowActive = false
  result.supportDrag = true
  result.dragMode = false
  result.panOffset = Vector2(x: 0, y: 0)

  # Init path data
  result.dirPathEditMode = false
  result.filesListActive = -1
  result.prevFilesListActive = result.filesListActive
  result.filesListScrollIndex = 0
  result.fileNameEditMode = false
  result.selectFilePressed = false
  result.cancelFilePressed = false
  result.fileTypeActive = 0
  result.fileNameText = ""

  # Custom variables initialization
  if initPath.len > 0:
    if dirExists(initPath):
      result.dirPathText = initPath
    elif fileExists(initPath):
      result.dirPathText = initPath.parentDir
      result.fileNameText = initPath.extractFilename
    else:
      result.dirPathText = getCurrentDir()
  else:
    result.dirPathText = getCurrentDir()

  # Copy path data
  result.filterExt = ""
  result.dirFiles = @[]

proc getFileExtension(path: string): string =
  let extPos = searchExtPos(path)
  if extPos >= 0:
    result = path.substr(extPos).toLowerAscii
  else:
    result = ""

proc reloadDirectoryFiles(state: var GuiWindowFileDialogState) =
  state.dirFiles.setLen(0)

  state.itemFocused = 0
  dirFilesIcon.setLen(MaxDirectoryFiles)

  # Load all files and directories
  var fileCount = 0
  for kind, path in walkDir(state.dirPathText):
    if fileCount >= MaxDirectoryFiles:
      break

    let fileName = path.extractFilename
    let ext = getFileExtension(path)

    # Set appropriate icon based on file type
    let iconId =
      if kind == pcDir:
        GuiIconName.FolderFileOpen
      elif ext in [".png", ".bmp", ".tga", ".gif", ".jpg", ".jpeg",
                   ".psd", ".hdr", ".qoi", ".dds", ".pkm", ".ktx",
                   ".pvr", ".astc"]:
        GuiIconName.FiletypeImage
      elif ext in [".wav", ".mp3", ".ogg", ".flac", ".xm", ".mod",
                   ".it", ".wma", ".aiff"]:
        GuiIconName.FiletypeAudio
      elif ext in [".txt", ".info", ".md", ".nfo", ".nim", ".xml", ".json",
                   ".c", ".cpp", ".cs", ".lua", ".py", ".glsl",
                   ".vs", ".fs"]:
        GuiIconName.FiletypeText
      elif ext in [".exe", ".bin", ".raw", ".msi"]:
        GuiIconName.FileTypeBinary
      else:
        GuiIconName.File

    # Create new FileInfo with icon + text combination
    let fileInfo = FileInfo(
      name: iconText(iconId, fileName),
      size: if kind == pcFile: getFileSize(path) else: 0,
      modTime: getLastModificationTime(path).toUnix,
      fileType: if kind == pcDir: 1 else: 0,
      icon: iconId
    )

    # Add to our collections
    dirFilesIcon[fileCount] = fileInfo
    inc fileCount

  # Update total count
  state.dirFiles.setLen(fileCount)

proc getTextBounds(control: GuiControl, bounds: Rectangle): Rectangle =
  result = bounds
  result.x = bounds.x + guiGetStyle(control, BorderWidth).float32
  result.y = bounds.y + guiGetStyle(control, BorderWidth).float32 +
             guiGetStyle(control, TextPadding).float32
  result.width = bounds.width - 2 * guiGetStyle(control, BorderWidth).float32 -
                 2 * guiGetStyle(control, TextPadding).float32
  result.height = bounds.height - 2 * guiGetStyle(control, BorderWidth).float32 -
                  2 * guiGetStyle(control, TextPadding).float32

  # NOTE: Text is processed line per line!
  # Depending on control, TEXT_PADDING and TEXT_ALIGNMENT properties could affect the text-bounds
  case control
  of Combobox, Dropdownbox, ListView:
    # TODO: Special cases (no label): COMBOBOX, DROPDOWNBOX, LISTVIEW
    discard
  of Slider, Checkbox, Valuebox, Spinner:
    # TODO: More special cases (label on side): SLIDER, CHECKBOX, VALUEBOX, SPINNER
    discard
  else:
    # TODO: WARNING: TEXT_ALIGNMENT is already considered in GuiDrawText()
    if guiGetStyle(control, TextAlignment).GuiTextAlignment == Right:
      result.x -= guiGetStyle(control, TextPadding).float32
    else:
      result.x += guiGetStyle(control, TextPadding).float32

proc guiListViewFiles(bounds: Rectangle, files: openarray[FileInfo],
                      focus, scrollIndex, active: var int32): int32 =
  result = 0
  var state = guiGetState()
  var itemFocused = focus
  var itemSelected = active

  # Check if we need a scroll bar
  var useScrollBar = false
  if (guiGetStyle(ListView, ListItemsHeight) + guiGetStyle(ListView, ListItemsSpacing)) *
     files.len.int32 > bounds.height.int32:
    useScrollBar = true

  # Define base item rectangle [0]
  var itemBounds = Rectangle(
    x: bounds.x + guiGetStyle(ListView, ListItemsSpacing).float32,
    y: bounds.y + guiGetStyle(ListView, ListItemsSpacing).float32 + guiGetStyle(Default, BorderWidth).float32,
    width: bounds.width - 2 * guiGetStyle(ListView, ListItemsSpacing).float32 - guiGetStyle(Default, BorderWidth).float32,
    height: guiGetStyle(ListView, ListItemsHeight).float32
  )

  if useScrollBar:
    itemBounds.width -= guiGetStyle(ListView, ScrollbarWidth).float32

  # Get items on the list
  var visibleItems = (bounds.height /
    (guiGetStyle(ListView, ListItemsHeight).float32 +
     guiGetStyle(ListView, ListItemsSpacing).float32)).int32

  if visibleItems > files.len.int32:
    visibleItems = files.len.int32

  var startIndex = scrollIndex
  if startIndex < 0 or startIndex > (files.len.int32 - visibleItems):
    startIndex = 0
  var endIndex = startIndex + visibleItems

  # Update control
  if state != Disabled and not guiIsLocked():
    let mousePoint = getMousePosition()

    # Check mouse inside list view
    if checkCollisionPointRec(mousePoint, bounds):
      state = Focused
      guiSetState(state)

      # Check focused and selected item
      for i in 0..<visibleItems:
        if checkCollisionPointRec(mousePoint, itemBounds):
          itemFocused = startIndex + i
          if isMouseButtonPressed(Left):
            itemSelected = startIndex + i
          break

        # Update item rectangle y position for next item
        itemBounds.y += (guiGetStyle(ListView, ListItemsHeight).float32 +
                         guiGetStyle(ListView, ListItemsSpacing).float32)

      if useScrollBar:
        let wheelMove = getMouseWheelMove()
        startIndex -= wheelMove.int32

        if startIndex < 0:
          startIndex = 0
        elif startIndex > (files.len.int32 - visibleItems):
          startIndex = files.len.int32 - visibleItems

        endIndex = startIndex + visibleItems
        if endIndex > files.len.int32:
          endIndex = files.len.int32

    else:
      itemFocused = -1

  # Draw control
  let guiAlpha = guiGetAlpha()
  drawRectangle(bounds, getColor(guiGetStyle(Default, BackgroundColor).uint32))
  drawRectangleLines(bounds, guiGetStyle(Default, BorderWidth).float32,
    fade(getColor(guiGetStyle(ListView, ControlProperty(Border.int32 + state.int32 * 3)).uint32), guiAlpha))

  # Draw visible items
  for i in 0..<visibleItems:
    if state == Disabled:
      if (startIndex + i) == itemSelected:
        drawRectangle(itemBounds,
          fade(getColor(guiGetStyle(ListView, BaseColorDisabled).uint32), guiAlpha))
        drawRectangleLines(itemBounds, guiGetStyle(ListView, BorderWidth).float32,
          fade(getColor(guiGetStyle(ListView, BorderColorDisabled).uint32), guiAlpha))

      drawText(files[startIndex + i].name, getTextBounds(Default, itemBounds),
        guiGetStyle(ListView, TextAlignment),
        fade(getColor(guiGetStyle(ListView, TextColorDisabled).uint32), guiAlpha))
    else:
      if (startIndex + i) == itemSelected:
        # Draw item selected
        drawRectangle(itemBounds,
          fade(getColor(guiGetStyle(ListView, BaseColorPressed).uint32), guiAlpha))
        drawRectangleLines(itemBounds, guiGetStyle(ListView, BorderWidth).float32,
          fade(getColor(guiGetStyle(ListView, BorderColorPressed).uint32), guiAlpha))

        drawText(files[startIndex + i].name, getTextBounds(Default, itemBounds),
          guiGetStyle(ListView, TextAlignment),
          fade(getColor(guiGetStyle(ListView, TextColorPressed).uint32), guiAlpha))
      elif (startIndex + i) == itemFocused:
        # Draw item focused
        drawRectangle(itemBounds,
          fade(getColor(guiGetStyle(ListView, BaseColorFocused).uint32), guiAlpha))
        drawRectangleLines(itemBounds, guiGetStyle(ListView, BorderWidth).float32,
          fade(getColor(guiGetStyle(ListView, BorderColorFocused).uint32), guiAlpha))

        drawText(files[startIndex + i].name, getTextBounds(Default, itemBounds),
          guiGetStyle(ListView, TextAlignment),
          fade(getColor(guiGetStyle(ListView, TextColorFocused).uint32), guiAlpha))
      else:
        # Draw item normal
        drawText(files[startIndex + i].name, getTextBounds(Default, itemBounds),
          guiGetStyle(ListView, TextAlignment),
          fade(getColor(guiGetStyle(ListView, TextColorNormal).uint32), guiAlpha))

    # Update item rectangle y position for next item
    itemBounds.y += (guiGetStyle(ListView, ListItemsHeight).float32 +
                     guiGetStyle(ListView, ListItemsSpacing).float32)

  if useScrollBar:
    let scrollBarBounds = Rectangle(
      x: bounds.x + bounds.width - guiGetStyle(ListView, BorderWidth).float32 -
         guiGetStyle(ListView, ScrollbarWidth).float32,
      y: bounds.y + guiGetStyle(ListView, BorderWidth).float32,
      width: guiGetStyle(ListView, ScrollbarWidth).float32,
      height: bounds.height - 2 * guiGetStyle(Default, BorderWidth).float32
    )

    # Calculate percentage of visible items and apply same percentage to scrollbar
    let percentVisible = (endIndex - startIndex).float32 / files.len.float32
    let sliderSize = bounds.height * percentVisible

    let prevSliderSize = guiGetStyle(Scrollbar, SliderWidth)
    let prevScrollSpeed = guiGetStyle(Scrollbar, ScrollSpeed)
    guiSetStyle(Scrollbar, SliderWidth, sliderSize.int32)
    guiSetStyle(Scrollbar, ScrollSpeed, files.len.int32 - visibleItems)

    startIndex = guiScrollBar(scrollBarBounds, startIndex.float32, 0,
                             (files.len.int32 - visibleItems).float32).int32

    guiSetStyle(Scrollbar, ScrollSpeed, prevScrollSpeed)
    guiSetStyle(Scrollbar, SliderWidth, prevSliderSize)

  focus = itemFocused
  scrollIndex = startIndex
  active = itemSelected
