from raylib import Vector2, Vector3, Color, Rectangle, Texture2D, Image, GlyphInfo, Font
export Vector2, Vector3, Color, Rectangle, Texture2D, Image, GlyphInfo, Font

import std/[assertions, paths]
from std/strutils import align
const rayguiDir = currentSourcePath().Path.parentDir / Path"raygui"

# {.passC: "-DRAYGUI_IMPLEMENTATION".}
{.passC: "-I" & rayguiDir.string.}
{.compile: rayguiDir / Path"raygui.c".}

const
  RayguiVersion* = (4, 5, 0)

type
  ConstCstringArray {.importc: "const char **".} = object

proc toConstCStringArray(x: cstringArray): ConstCstringArray {.
    importc: "(const char **)", noconv, nodecl.}

type
  GuiState* {.size: sizeof(int32).} = enum ## Gui control state
    Normal
    Focused
    Pressed
    Disabled

  GuiTextAlignment* {.size: sizeof(int32).} = enum ## Gui control text alignment
    Left
    Center
    Right

  GuiTextAlignmentVertical* {.size: sizeof(int32).} = enum ## Gui control text alignment vertical
    Top
    Middle
    Bottom

  GuiTextWrapMode* {.size: sizeof(int32).} = enum ## Gui control text wrap mode
    TextWrapNone
    TextWrapChar
    TextWrapWord

  GuiControl* {.size: sizeof(int32).} = enum ## Gui controls
    Default
    Label ## Used also for: LABELBUTTON
    Button
    Toggle ## Used also for: TOGGLEGROUP
    Slider ## Used also for: SLIDERBAR, TOGGLESLIDER
    Progressbar
    Checkbox
    Combobox
    Dropdownbox
    Textbox ## Used also for: TEXTBOXMULTI
    Valuebox
    Control11
    Listview
    Colorpicker
    Scrollbar
    Statusbar

  ControlProperty* {.size: sizeof(int32).} = enum ## Gui base properties for every control
    BorderColorNormal ## Control border color in STATE_NORMAL
    BaseColorNormal ## Control base color in STATE_NORMAL
    TextColorNormal ## Control text color in STATE_NORMAL
    BorderColorFocused ## Control border color in STATE_FOCUSED
    BaseColorFocused ## Control base color in STATE_FOCUSED
    TextColorFocused ## Control text color in STATE_FOCUSED
    BorderColorPressed ## Control border color in STATE_PRESSED
    BaseColorPressed ## Control base color in STATE_PRESSED
    TextColorPressed ## Control text color in STATE_PRESSED
    BorderColorDisabled ## Control border color in STATE_DISABLED
    BaseColorDisabled ## Control base color in STATE_DISABLED
    TextColorDisabled ## Control text color in STATE_DISABLED
    BorderWidth ## Control border size, 0 for no border
    TextPadding ## Control text padding, not considering border
    TextAlignment ## Control text horizontal alignment inside control text bound (after border and padding)

  DefaultProperty* {.size: sizeof(int32).} = enum ## DEFAULT extended properties
    TextSize = 16 ## Text size (glyphs max height)
    TextSpacing ## Text spacing between glyphs
    LineColor ## Line control color
    BackgroundColor ## Background color
    TextLineSpacing ## Text spacing between lines
    TextAlignmentVertical ## Text vertical alignment inside text bounds (after border and padding)
    TextWrapMode ## Text wrap-mode inside text bounds

  ToggleProperty* {.size: sizeof(int32).} = enum ## Toggle/ToggleGroup
    GroupPadding = 16 ## ToggleGroup separation between toggles

  SliderProperty* {.size: sizeof(int32).} = enum ## Slider/SliderBar
    SliderWidth = 16 ## Slider size of internal bar
    SliderPadding ## Slider/SliderBar internal bar padding

  ProgressBarProperty* {.size: sizeof(int32).} = enum ## ProgressBar
    ProgressPadding = 16 ## ProgressBar internal padding

  ScrollBarProperty* {.size: sizeof(int32).} = enum ## ScrollBar
    ArrowsSize = 16 ## ScrollBar arrows size
    ArrowsVisible ## ScrollBar arrows visible
    ScrollSliderPadding ## ScrollBar slider internal padding
    ScrollSliderSize ## ScrollBar slider size
    ScrollPadding ## ScrollBar scroll padding from arrows
    ScrollSpeed ## ScrollBar scrolling speed

  CheckBoxProperty* {.size: sizeof(int32).} = enum ## CheckBox
    CheckPadding = 16 ## CheckBox internal check padding

  ComboBoxProperty* {.size: sizeof(int32).} = enum ## ComboBox
    ComboButtonWidth = 16 ## ComboBox right button width
    ComboButtonSpacing ## ComboBox button separation

  DropdownBoxProperty* {.size: sizeof(int32).} = enum ## DropdownBox
    ArrowPadding = 16 ## DropdownBox arrow separation from border and items
    DropdownItemsSpacing ## DropdownBox items separation
    DropdownArrowHidden ## DropdownBox arrow hidden
    DropdownRollUp ## DropdownBox roll up flag (default rolls down)

  TextBoxProperty* {.size: sizeof(int32).} = enum ## TextBox/TextBoxMulti/ValueBox/Spinner
    TextReadonly = 16 ## TextBox in read-only mode: 0-text editable, 1-text no-editable

  ValueBoxProperty* {.size: sizeof(int32).} = enum ## ValueBox/Spinner
    SpinnerButtonWidth = 16 ## Spinner left/right buttons width
    SpinnerButtonSpacing ## Spinner buttons separation

  ListViewProperty* {.size: sizeof(int32).} = enum ## ListView
    ListItemsHeight = 16 ## ListView items height
    ListItemsSpacing ## ListView items separation
    ScrollbarWidth ## ListView scrollbar size (usually width)
    ScrollbarSide ## ListView scrollbar side (0-SCROLLBAR_LEFT_SIDE, 1-SCROLLBAR_RIGHT_SIDE)
    ListItemsBorderNormal ## ListView items border enabled in normal state
    ListItemsBorderWidth ## ListView items border width

  ColorPickerProperty* {.size: sizeof(int32).} = enum ## ColorPicker
    ColorSelectorSize = 16
    HuebarWidth ## ColorPicker right hue bar width
    HuebarPadding ## ColorPicker right hue bar separation from panel
    HuebarSelectorHeight ## ColorPicker right hue bar selector height
    HuebarSelectorOverflow ## ColorPicker right hue bar selector overflow

  GuiIconName* {.size: sizeof(int32).} = enum
    None
    FolderFileOpen
    FileSaveClassic
    FolderOpen
    FolderSave
    FileOpen
    FileSave
    FileExport
    FileAdd
    FileDelete
    FiletypeText
    FiletypeAudio
    FiletypeImage
    FiletypePlay
    FiletypeVideo
    FiletypeInfo
    FileCopy
    FileCut
    FilePaste
    CursorHand
    CursorPointer
    CursorClassic
    Pencil
    PencilBig
    BrushClassic
    BrushPainter
    WaterDrop
    ColorPicker
    Rubber
    ColorBucket
    TextT
    TextA
    Scale
    Resize
    FilterPoint
    FilterBilinear
    Crop
    CropAlpha
    SquareToggle
    Symmetry
    SymmetryHorizontal
    SymmetryVertical
    Lens
    LensBig
    EyeOn
    EyeOff
    FilterTop
    Filter
    TargetPoint
    TargetSmall
    TargetBig
    TargetMove
    CursorMove
    CursorScale
    CursorScaleRight
    CursorScaleLeft
    Undo
    Redo
    Reredo
    Mutate
    Rotate
    Repeat
    Shuffle
    Emptybox
    Target
    TargetSmallFill
    TargetBigFill
    TargetMoveFill
    CursorMoveFill
    CursorScaleFill
    CursorScaleRightFill
    CursorScaleLeftFill
    UndoFill
    RedoFill
    ReredoFill
    MutateFill
    RotateFill
    RepeatFill
    ShuffleFill
    EmptyboxSmall
    Box
    BoxTop
    BoxTopRight
    BoxRight
    BoxBottomRight
    BoxBottom
    BoxBottomLeft
    BoxLeft
    BoxTopLeft
    BoxCenter
    BoxCircleMask
    Pot
    AlphaMultiply
    AlphaClear
    Dithering
    Mipmaps
    BoxGrid
    Grid
    BoxCornersSmall
    BoxCornersBig
    FourBoxes
    GridFill
    BoxMultisize
    ZoomSmall
    ZoomMedium
    ZoomBig
    ZoomAll
    ZoomCenter
    BoxDotsSmall
    BoxDotsBig
    BoxConcentric
    BoxGridBig
    OkTick
    Cross
    ArrowLeft
    ArrowRight
    ArrowDown
    ArrowUp
    ArrowLeftFill
    ArrowRightFill
    ArrowDownFill
    ArrowUpFill
    Audio
    Fx
    Wave
    WaveSinus
    WaveSquare
    WaveTriangular
    CrossSmall
    PlayerPrevious
    PlayerPlayBack
    PlayerPlay
    PlayerPause
    PlayerStop
    PlayerNext
    PlayerRecord
    Magnet
    LockClose
    LockOpen
    Clock
    Tools
    Gear
    GearBig
    Bin
    HandPointer
    Laser
    Coin
    Explosion
    Icon1up
    Player
    PlayerJump
    Key
    Demon
    TextPopup
    GearEx
    Crack
    CrackPoints
    Star
    Door
    Exit
    Mode2d
    Mode3d
    Cube
    CubeFaceTop
    CubeFaceLeft
    CubeFaceFront
    CubeFaceBottom
    CubeFaceRight
    CubeFaceBack
    Camera
    Special
    LinkNet
    LinkBoxes
    LinkMulti
    Link
    LinkBroke
    TextNotes
    Notebook
    Suitcase
    SuitcaseZip
    Mailbox
    Monitor
    Printer
    PhotoCamera
    PhotoCameraFlash
    House
    Heart
    Corner
    VerticalBars
    VerticalBarsFill
    LifeBars
    Info
    Crossline
    Help
    FiletypeAlpha
    FiletypeHome
    LayersVisible
    Layers
    Window
    Hidpi
    FiletypeBinary
    Hex
    Shield
    FileNew
    FolderAdd
    Alarm
    Cpu
    Rom
    StepOver
    StepInto
    StepOut
    Restart
    BreakpointOn
    BreakpointOff
    BurgerMenu
    CaseSensitive
    RegExp
    Folder
    File
    SandTimer
    Warning
    HelpBox
    InfoBox
    Priority
    LayersIso
    Layers2
    Mlayers
    Maps
    Hot
    Icon229
    Icon230
    Icon231
    Icon232
    Icon233
    Icon234
    Icon235
    Icon236
    Icon237
    Icon238
    Icon239
    Icon240
    Icon241
    Icon242
    Icon243
    Icon244
    Icon245
    Icon246
    Icon247
    Icon248
    Icon249
    Icon250
    Icon251
    Icon252
    Icon253
    Icon254
    Icon255

const
  ScrollbarLeftSide* = 0
  ScrollbarRightSide* = 1

type
  StyleProp* {.importc: "GuiStyleProp", header: "raygui.h", completeStruct, bycopy.} = object ## NOTE: Used when exporting style as code for convenience
    controlId*: uint16 ## Control identifier
    propertyId*: uint16 ## Property identifier
    propertyValue*: int32 ## Property value

  TextStyle* {.importc: "GuiTextStyle", header: "raygui.h", completeStruct, bycopy.} = object ## NOTE: Text style is defined by control
    size*: uint32
    charSpacing*: int32
    lineSpacing*: int32
    alignmentH*: int32
    alignmentV*: int32
    padding*: int32



{.push callconv: cdecl, header: "raygui.h".}
proc guiEnable*() {.importc: "GuiEnable", sideEffect.}
  ## Enable gui controls (global state)
proc guiDisable*() {.importc: "GuiDisable", sideEffect.}
  ## Disable gui controls (global state)
proc guiLock*() {.importc: "GuiLock", sideEffect.}
  ## Lock gui controls (global state)
proc guiUnlock*() {.importc: "GuiUnlock", sideEffect.}
  ## Unlock gui controls (global state)
proc guiIsLocked*(): bool {.importc: "GuiIsLocked", sideEffect.}
  ## Check if gui is locked (global state)
proc guiSetAlpha*(alpha: float32) {.importc: "GuiSetAlpha", sideEffect.}
  ## Set gui controls alpha (global state), alpha goes from 0.0f to 1.0f
proc guiSetState*(state: GuiState) {.importc: "GuiSetState", sideEffect.}
  ## Set gui state (global state)
proc guiGetState*(): GuiState {.importc: "GuiGetState", sideEffect.}
  ## Get gui state (global state)
proc guiSetFont*(font: Font) {.importc: "GuiSetFont", sideEffect.}
  ## Set gui custom font (global state)
proc guiGetFont*(): Font {.importc: "GuiGetFont", sideEffect.}
  ## Get gui custom font (global state)
proc guiSetStyleImpl(control: GuiControl, property: int32, value: int32) {.importc: "GuiSetStyle", sideEffect.}
proc guiGetStyleImpl(control: GuiControl, property: int32): int32 {.importc: "GuiGetStyle", sideEffect.}
proc guiLoadStyleImpl(fileName: cstring) {.importc: "GuiLoadStyle", sideEffect.}
proc guiLoadStyleDefault*() {.importc: "GuiLoadStyleDefault", sideEffect.}
  ## Load style default over global style
proc enableTooltip*() {.importc: "GuiEnableTooltip", sideEffect.}
  ## Enable gui tooltips (global state)
proc disableTooltip*() {.importc: "GuiDisableTooltip", sideEffect.}
  ## Disable gui tooltips (global state)
proc setTooltipImpl(tooltip: cstring) {.importc: "GuiSetTooltip", sideEffect.}
proc setIconScale*(scale: int32) {.importc: "GuiSetIconScale", sideEffect.}
  ## Set default icon drawing size
proc getIcons*(): var uint32 {.importc: "GuiGetIcons", sideEffect.}
  ## Get raygui icons data pointer
proc loadIconsImpl(fileName: cstring, loadIconsName: bool): cstringArray {.importc: "GuiLoadIcons", sideEffect.}
proc drawIcon*(iconId: GuiIconName, posX: int32, posY: int32, pixelSize: int32, color: Color) {.importc: "GuiDrawIcon", sideEffect.}
  ## Draw icon using pixel size at specified position
proc windowBoxImpl(bounds: Rectangle, title: cstring): int32 {.importc: "GuiWindowBox", sideEffect.}
proc groupBoxImpl(bounds: Rectangle, text: cstring): int32 {.importc: "GuiGroupBox", sideEffect.}
proc lineImpl(bounds: Rectangle, text: cstring): int32 {.importc: "GuiLine", sideEffect.}
proc panelImpl(bounds: Rectangle, text: cstring): int32 {.importc: "GuiPanel", sideEffect.}
proc tabBarImpl(bounds: Rectangle, text: ConstCstringArray, count: int32, active: ptr int32): int32 {.importc: "GuiTabBar", sideEffect.}
proc scrollPanelImpl(bounds: Rectangle, text: cstring, content: Rectangle, scroll: ptr Vector2, view: out Rectangle): int32 {.importc: "GuiScrollPanel", sideEffect.}
proc labelImpl(bounds: Rectangle, text: cstring): int32 {.importc: "GuiLabel", sideEffect.}
proc buttonImpl(bounds: Rectangle, text: cstring): int32 {.importc: "GuiButton", sideEffect.}
proc labelButtonImpl(bounds: Rectangle, text: cstring): int32 {.importc: "GuiLabelButton", sideEffect.}
proc toggleImpl(bounds: Rectangle, text: cstring, active: ptr bool): int32 {.importc: "GuiToggle", sideEffect.}
proc toggleGroupImpl(bounds: Rectangle, text: cstring, active: ptr int32): int32 {.importc: "GuiToggleGroup", sideEffect.}
proc toggleSliderImpl(bounds: Rectangle, text: cstring, active: ptr int32): int32 {.importc: "GuiToggleSlider", sideEffect.}
proc checkBoxImpl(bounds: Rectangle, text: cstring, checked: ptr bool): int32 {.importc: "GuiCheckBox", sideEffect.}
proc comboBoxImpl(bounds: Rectangle, text: cstring, active: ptr int32): int32 {.importc: "GuiComboBox", sideEffect.}
proc dropdownBoxImpl(bounds: Rectangle, text: cstring, active: ptr int32, editMode: bool): int32 {.importc: "GuiDropdownBox", sideEffect.}
proc spinnerImpl(bounds: Rectangle, text: cstring, value: ptr int32, minValue: int32, maxValue: int32, editMode: bool): int32 {.importc: "GuiSpinner", sideEffect.}
proc valueBoxImpl(bounds: Rectangle, text: cstring, value: ptr int32, minValue: int32, maxValue: int32, editMode: bool): int32 {.importc: "GuiValueBox", sideEffect.}
proc valueBoxFloatImpl(bounds: Rectangle, text: cstring, textValue: cstring, value: ptr float32, editMode: bool): int32 {.importc: "GuiValueBoxFloat", sideEffect.}
proc textBoxImpl(bounds: Rectangle, text: cstring, textSize: int32, editMode: bool): int32 {.importc: "GuiTextBox", sideEffect.}
proc sliderImpl(bounds: Rectangle, textLeft: cstring, textRight: cstring, value: ptr float32, minValue: float32, maxValue: float32): int32 {.importc: "GuiSlider", sideEffect.}
proc sliderProImpl(bounds: Rectangle, textLeft: cstring, textRight: cstring, value: ptr float32, minValue: float32, maxValue: float32, sliderWidth: int32): int32 {.importc: "GuiSliderPro", sideEffect.}
proc sliderBarImpl(bounds: Rectangle, textLeft: cstring, textRight: cstring, value: ptr float32, minValue: float32, maxValue: float32): int32 {.importc: "GuiSliderBar", sideEffect.}
proc progressBarImpl(bounds: Rectangle, textLeft: cstring, textRight: cstring, value: ptr float32, minValue: float32, maxValue: float32): int32 {.importc: "GuiProgressBar", sideEffect.}
proc statusBarImpl(bounds: Rectangle, text: cstring): int32 {.importc: "GuiStatusBar", sideEffect.}
proc dummyRecImpl(bounds: Rectangle, text: cstring): int32 {.importc: "GuiDummyRec", sideEffect.}
proc gridImpl(bounds: Rectangle, text: cstring, spacing: float32, subdivs: int32, mouseCell: out Vector2): int32 {.importc: "GuiGrid", sideEffect.}
proc listViewImpl(bounds: Rectangle, text: cstring, scrollIndex: ptr int32, active: ptr int32): int32 {.importc: "GuiListView", sideEffect.}
proc listViewImpl(bounds: Rectangle, text: ConstCstringArray, count: int32, scrollIndex: ptr int32, active: ptr int32, focus: ptr int32): int32 {.importc: "GuiListViewEx", sideEffect.}
proc messageBoxImpl(bounds: Rectangle, title: cstring, message: cstring, buttons: cstring): int32 {.importc: "GuiMessageBox", sideEffect.}
proc textInputBoxImpl(bounds: Rectangle, title: cstring, message: cstring, buttons: cstring, text: cstring, textMaxSize: int32, secretViewActive: ptr bool): int32 {.importc: "GuiTextInputBox", sideEffect.}
proc colorPickerImpl(bounds: Rectangle, text: cstring, color: ptr Color): int32 {.importc: "GuiColorPicker", sideEffect.}
proc colorPanelImpl(bounds: Rectangle, text: cstring, color: ptr Color): int32 {.importc: "GuiColorPanel", sideEffect.}
proc colorBarAlphaImpl(bounds: Rectangle, text: cstring, alpha: ptr float32): int32 {.importc: "GuiColorBarAlpha", sideEffect.}
proc colorBarHueImpl(bounds: Rectangle, text: cstring, value: ptr float32): int32 {.importc: "GuiColorBarHue", sideEffect.}
proc colorPickerHSVImpl(bounds: Rectangle, text: cstring, colorHsv: ptr Vector3): int32 {.importc: "GuiColorPickerHSV", sideEffect.}
proc colorPanelHSVImpl(bounds: Rectangle, text: cstring, colorHsv: ptr Vector3): int32 {.importc: "GuiColorPanelHSV", sideEffect.}
{.pop.}


proc guiLoadStyle*(fileName: string) =
  ## Load style file over global style variable (.rgs)
  guiLoadStyleImpl(fileName.cstring)

proc setTooltip*(tooltip: string) =
  ## Set tooltip string
  setTooltipImpl(if tooltip.len == 0: nil else: tooltip.cstring)

proc windowBox*(bounds: Rectangle, title: string): bool =
  ## Window Box control, shows a window that can be closed
  windowBoxImpl(bounds, title.cstring) != 0

proc groupBox*(bounds: Rectangle, text: string) =
  ## Group Box control with text name
  discard groupBoxImpl(bounds, if text.len == 0: nil else: text.cstring)

proc line*(bounds: Rectangle, text: string) =
  ## Line separator control, could contain text
  discard lineImpl(bounds, if text.len == 0: nil else: text.cstring)

proc panel*(bounds: Rectangle, text: string) =
  ## Panel control, useful to group controls
  discard panelImpl(bounds, if text.len == 0: nil else: text.cstring)

proc scrollPanel*(bounds: Rectangle, text: string, content: Rectangle, scroll: var Vector2, view: out Rectangle) =
  ## Scroll Panel control
  discard scrollPanelImpl(bounds, if text.len == 0: nil else: text.cstring, content, addr scroll, view)

proc label*(bounds: Rectangle, text: string) =
  ## Label control
  discard labelImpl(bounds, text.cstring)

proc button*(bounds: Rectangle, text: string): bool =
  ## Button control, returns true when clicked
  buttonImpl(bounds, text.cstring) != 0

proc labelButton*(bounds: Rectangle, text: string): bool =
  ## Label button control, returns true when clicked
  labelButtonImpl(bounds, text.cstring) != 0

proc toggle*(bounds: Rectangle, text: string, active: var bool) =
  ## Toggle Button control
  discard toggleImpl(bounds, text.cstring, addr active)

proc toggleGroup*(bounds: Rectangle, text: string, active: var int32) =
  ## Toggle Group control
  discard toggleGroupImpl(bounds, text.cstring, addr active)

proc toggleSlider*(bounds: Rectangle, text: string, active: var int32): bool =
  ## Toggle Slider control
  toggleSliderImpl(bounds, if text.len == 0: nil else: text.cstring, addr active) != 0

proc checkBox*(bounds: Rectangle, text: string, checked: var bool): bool =
  ## Check Box control, returns true when active
  checkBoxImpl(bounds, if text.len == 0: nil else: text.cstring, addr checked) != 0

proc comboBox*(bounds: Rectangle, text: string, active: var int32) =
  ## Combo Box control
  discard comboBoxImpl(bounds, text.cstring, addr active)

proc dropdownBox*(bounds: Rectangle, text: string, active: var int32, editMode: bool): bool =
  ## Dropdown Box control
  dropdownBoxImpl(bounds, text.cstring, addr active, editMode) != 0

proc spinner*(bounds: Rectangle, text: string, value: var int32, minValue: int32, maxValue: int32, editMode: bool): bool =
  ## Spinner control
  spinnerImpl(bounds, if text.len == 0: nil else: text.cstring, addr value, minValue, maxValue, editMode) != 0

proc valueBox*(bounds: Rectangle, text: string, value: var int32, minValue: int32, maxValue: int32, editMode: bool): bool =
  ## Value Box control, updates input text with numbers
  valueBoxImpl(bounds, if text.len == 0: nil else: text.cstring, addr value, minValue, maxValue, editMode) != 0

proc valueBoxFloat*(bounds: Rectangle, text: string, textValue: string, value: var float32, editMode: bool): bool =
  ## Value box control for float values
  valueBoxFloatImpl(bounds, if text.len == 0: nil else: text.cstring, textValue.cstring, addr value, editMode) != 0

proc slider*(bounds: Rectangle, textLeft: string, textRight: string, value: var float32, minValue: float32, maxValue: float32): bool =
  ## Slider control
  sliderImpl(bounds, if textLeft.len == 0: nil else: textLeft.cstring, if textRight.len == 0: nil else: textRight.cstring, addr value, minValue, maxValue) != 0

proc sliderPro*(bounds: Rectangle, textLeft: string, textRight: string, value: var float32, minValue: float32, maxValue: float32, sliderWidth: int32): int32 =
  ## Slider control with extended parameters
  sliderProImpl(bounds, textLeft.cstring, textRight.cstring, addr value, minValue, maxValue, sliderWidth)

proc sliderBar*(bounds: Rectangle, textLeft: string, textRight: string, value: var float32, minValue: float32, maxValue: float32): bool =
  ## Slider Bar control
  sliderBarImpl(bounds, if textLeft.len == 0: nil else: textLeft.cstring, if textRight.len == 0: nil else: textRight.cstring, addr value, minValue, maxValue) != 0

proc progressBar*(bounds: Rectangle, textLeft: string, textRight: string, value: var float32, minValue: float32, maxValue: float32) =
  ## Progress Bar control
  discard progressBarImpl(bounds, if textLeft.len == 0: nil else: textLeft.cstring, if textRight.len == 0: nil else: textRight.cstring, addr value, minValue, maxValue)

proc statusBar*(bounds: Rectangle, text: string) =
  ## Status Bar control, shows info text
  discard statusBarImpl(bounds, text.cstring)

proc dummyRec*(bounds: Rectangle, text: string) =
  ## Dummy control for placeholders
  discard dummyRecImpl(bounds, text.cstring)

proc grid*(bounds: Rectangle, text: string, spacing: float32, subdivs: int32, mouseCell: out Vector2) =
  ## Grid control
  discard gridImpl(bounds, text.cstring, spacing, subdivs, mouseCell)

proc listView*(bounds: Rectangle, text: string, scrollIndex: var int32, active: var int32) =
  ## List View control
  discard listViewImpl(bounds, if text.len == 0: nil else: text.cstring, addr scrollIndex, addr active)

proc messageBox*(bounds: Rectangle, title: string, message: string, buttons: string): int32 =
  ## Message Box control, displays a message
  messageBoxImpl(bounds, title.cstring, message.cstring, buttons.cstring)

proc colorPicker*(bounds: Rectangle, text: string, color: var Color) =
  ## Color Picker control (multiple color controls)
  discard colorPickerImpl(bounds, text.cstring, addr color)

proc colorPanel*(bounds: Rectangle, text: string, color: var Color) =
  ## Color Panel control
  discard colorPanelImpl(bounds, text.cstring, addr color)

proc colorBarAlpha*(bounds: Rectangle, text: string, alpha: var float32) =
  ## Color Bar Alpha control
  discard colorBarAlphaImpl(bounds, text.cstring, addr alpha)

proc colorBarHue*(bounds: Rectangle, text: string, value: var float32) =
  ## Color Bar Hue control
  discard colorBarHueImpl(bounds, text.cstring, addr value)

proc colorPickerHSV*(bounds: Rectangle, text: string, colorHsv: var Vector3) =
  ## Color Picker control that avoids conversion to RGB on each call (multiple color controls)
  discard colorPickerHSVImpl(bounds, text.cstring, addr colorHsv)

proc colorPanelHSV*(bounds: Rectangle, text: string, colorHsv: var Vector3) =
  ## Color Panel control that updates Hue-Saturation-Value color value, used by GuiColorPickerHSV()
  discard colorPanelHSVImpl(bounds, text.cstring, addr colorHsv)

type
  TextArray* = object
    data: cstringArray
    count: int32

proc `=destroy`*(t: TextArray) =
  if t.data != nil:
    deallocCStringArray(t.data)
proc `=dup`*(source: TextArray): TextArray {.error.}
proc `=copy`*(dest: var TextArray; source: TextArray) {.error.}

proc toTextArray*(texts: openArray[string]): TextArray =
  TextArray(data: allocCStringArray(texts), count: texts.len.int32)

proc memFree(`ptr`: pointer) {.importc: "RAYGUI_FREE", sideEffect.}

proc listView*(bounds: Rectangle, text: TextArray, scrollIndex: var int32, active: var int32, focus: var int32) =
  ## List View with extended parameters
  discard listViewImpl(bounds, toConstCStringArray(text.data), text.count, addr scrollIndex, addr active, addr focus)

proc tabBar*(bounds: Rectangle, text: TextArray, active: var int32): int32 =
  ## Tab Bar control, returns TAB to be closed or -1
  tabBarImpl(bounds, toConstCStringArray(text.data), text.count, addr active)

proc loadIcons*(fileName: string, loadIconsName: bool): seq[string] =
  ## Load raygui icons file (.rgi) into internal icons data
  let iconsName = loadIconsImpl(fileName.cstring, loadIconsName)
  result = cstringArrayToSeq(iconsName)
  memFree(iconsName)

template setupTextBox(call: untyped): untyped =
  # Helper template to set up a text box with common code.
  if text.len == 0:
    assert text.capacity != 0, "Expects a preallocated string buffer."
    text.setLen(1)
    text[0] = '\0'
  result = call
  if result.int32 == 1:
    text.setLen(text.cstring.len)

proc textBox*(bounds: Rectangle, text: var string, editMode: bool): bool =
  ## Text Box control, updates input text
  setupTextBox:
    textBoxImpl(bounds, text.cstring, text.capacity.int32 + 1, editMode) != 0

proc textInputBox*(bounds: Rectangle, title: string, message: string, buttons: string, text: var string, secretViewActive: var bool): int32 =
  ## Text Input Box control, ask for text, supports secret.
  setupTextBox:
    textInputBoxImpl(bounds, title.cstring, if message.len == 0: nil else: message.cstring, buttons.cstring, text.cstring, text.capacity.int32 + 1, addr secretViewActive)

proc textInputBox*(bounds: Rectangle, title: string, message: string, buttons: string, text: var string): int32 =
  ## Text Input Box control, ask for text, without secret.
  setupTextBox:
    textInputBoxImpl(bounds, title.cstring, if message.len == 0: nil else: message.cstring, buttons.cstring, text.cstring, text.capacity.int32 + 1, nil)

type
  GuiStyleProperty* = ControlProperty|DefaultProperty|ToggleProperty|SliderProperty|
                      ProgressBarProperty|ScrollBarProperty|CheckBoxProperty|
                      ComboBoxProperty|DropdownBoxProperty|TextBoxProperty|
                      SpinnerProperty|ListViewProperty|ColorPickerProperty

  GuiStyleValue* = GuiState|GuiTextAlignment|GuiTextAlignmentVertical|
                   GuiTextWrapMode|GuiControl|int32|bool

template validatePropertyControlMapping(control, property: untyped) =
  when property is ControlProperty:
    discard "ControlProperty applies to all controls"
  elif property is DefaultProperty:
    assert control == Default, "DefaultProperty should match Default control"
  elif property is ToggleProperty:
    assert control == Toggle, "ToggleProperty should match Toggle control"
  elif property is SliderProperty:
    assert control == Slider, "SliderProperty should match Slider control"
  elif property is ProgressBarProperty:
    assert control == Progressbar, "ProgressBarProperty should match Progressbar control"
  elif property is ScrollBarProperty:
    assert control == Scrollbar, "ScrollBarProperty should match Scrollbar control"
  elif property is CheckBoxProperty:
    assert control == Checkbox, "CheckBoxProperty should match Checkbox control"
  elif property is ComboBoxProperty:
    assert control == Combobox, "ComboBoxProperty should match Combobox control"
  elif property is DropdownBoxProperty:
    assert control == Dropdownbox, "DropdownBoxProperty should match Dropdownbox control"
  elif property is TextBoxProperty:
    assert control == Textbox, "TextBoxProperty should match Textbox control"
  elif property is SpinnerProperty:
    assert control == Spinner, "SpinnerProperty should match Spinner control"
  elif property is ListViewProperty:
    assert control == Listview, "ListViewProperty should match Listview control"
  elif property is ColorPickerProperty:
    assert control == Colorpicker, "ColorPickerProperty should match Colorpicker control"

proc guiSetStyle*[P: GuiStyleProperty, V: GuiStyleValue](control: GuiControl, property: P, value: V) =
  ## Set one style property
  validatePropertyControlMapping(control, P)
  guiSetStyleImpl(control, property.int32, value.int32)

proc guiGetStyle*[P: GuiStyleProperty](control: GuiControl, property: P): int32 =
  ## Get one style property
  validatePropertyControlMapping(control, P)
  guiGetStyleImpl(control, property.int32)

proc iconText*(iconId: GuiIconName, text: string = ""): string =
  ## Get text with icon id prepended (if supported)
  when defined(NayguiNoIcons):
    result = ""
  else:
    result = "#" & align($iconId.ord, 3, '0') & "#"
    if text.len > 0:
      result = result & text
