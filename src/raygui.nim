from raylib import Vector2, Vector3, Color, Rectangle, Texture2D, Image, GlyphInfo, Font
export Vector2, Vector3, Color, Rectangle, Texture2D, Image, GlyphInfo, Font

import std/paths
const rayguiDir = currentSourcePath().Path.parentDir / Path"raygui/src"

{.passC: "-I" & rayguiDir.string.}
{.passC: "-DRAYGUI_IMPLEMENTATION".}

const
  RayguiVersion* = (4, 5, 0)

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
    Spinner ## Uses: BUTTON, VALUEBOX
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

  SpinnerProperty* {.size: sizeof(int32).} = enum ## Spinner
    SpinButtonWidth = 16 ## Spinner left/right buttons width
    SpinButtonSpacing ## Spinner buttons separation

  ListViewProperty* {.size: sizeof(int32).} = enum ## ListView
    ListItemsHeight = 16 ## ListView items height
    ListItemsSpacing ## ListView items separation
    ScrollbarWidth ## ListView scrollbar size (usually width)
    ScrollbarSide ## ListView scrollbar side (0-SCROLLBAR_LEFT_SIDE, 1-SCROLLBAR_RIGHT_SIDE)
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
proc setAlpha*(alpha: float32) {.importc: "GuiSetAlpha", sideEffect.}
  ## Set gui controls alpha (global state), alpha goes from 0.0f to 1.0f
proc setState*(state: GuiState) {.importc: "GuiSetState", sideEffect.}
  ## Set gui state (global state)
proc getState*(): GuiState {.importc: "GuiGetState", sideEffect.}
  ## Get gui state (global state)
proc setFont*(font: Font) {.importc: "GuiSetFont", sideEffect.}
  ## Set gui custom font (global state)
proc getFont*(): Font {.importc: "GuiGetFont", sideEffect.}
  ## Get gui custom font (global state)
proc setStyle*(control: GuiControl, property: int32, value: int32) {.importc: "GuiSetStyle", sideEffect.}
  ## Set one style property
proc getStyle*(control: GuiControl, property: int32): int32 {.importc: "GuiGetStyle", sideEffect.}
  ## Get one style property
proc loadStyleImpl(fileName: cstring) {.importc: "GuiLoadStyle", sideEffect.}
proc loadStyleDefault*() {.importc: "GuiLoadStyleDefault", sideEffect.}
  ## Load style default over global style
proc enableTooltip*() {.importc: "GuiEnableTooltip", sideEffect.}
  ## Enable gui tooltips (global state)
proc disableTooltip*() {.importc: "GuiDisableTooltip", sideEffect.}
  ## Disable gui tooltips (global state)
proc setTooltipImpl(tooltip: cstring) {.importc: "GuiSetTooltip", sideEffect.}
proc iconTextImpl(iconId: GuiIconName, text: cstring): cstring {.importc: "GuiIconText", sideEffect.}
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
proc tabBar*(bounds: Rectangle, text: cstringArray, count: int32, active: out int32): int32 {.importc: "GuiTabBar", sideEffect.}
  ## Tab Bar control, returns TAB to be closed or -1
proc scrollPanelImpl(bounds: Rectangle, text: cstring, content: Rectangle, scroll: out Vector2, view: out Rectangle): int32 {.importc: "GuiScrollPanel", sideEffect.}
proc labelImpl(bounds: Rectangle, text: cstring): int32 {.importc: "GuiLabel", sideEffect.}
proc buttonImpl(bounds: Rectangle, text: cstring): int32 {.importc: "GuiButton", sideEffect.}
proc labelButtonImpl(bounds: Rectangle, text: cstring): int32 {.importc: "GuiLabelButton", sideEffect.}
proc toggleImpl(bounds: Rectangle, text: cstring, active: out bool): int32 {.importc: "GuiToggle", sideEffect.}
proc toggleGroupImpl(bounds: Rectangle, text: cstring, active: out int32): int32 {.importc: "GuiToggleGroup", sideEffect.}
proc toggleSliderImpl(bounds: Rectangle, text: cstring, active: out int32): int32 {.importc: "GuiToggleSlider", sideEffect.}
proc checkBoxImpl(bounds: Rectangle, text: cstring, checked: ptr bool): int32 {.importc: "GuiCheckBox", sideEffect.}
proc comboBoxImpl(bounds: Rectangle, text: cstring, active: out int32): int32 {.importc: "GuiComboBox", sideEffect.}
proc dropdownBoxImpl(bounds: Rectangle, text: cstring, active: out int32, editMode: bool): int32 {.importc: "GuiDropdownBox", sideEffect.}
proc spinnerImpl(bounds: Rectangle, text: cstring, value: out int32, minValue: int32, maxValue: int32, editMode: bool): int32 {.importc: "GuiSpinner", sideEffect.}
proc valueBoxImpl(bounds: Rectangle, text: cstring, value: out int32, minValue: int32, maxValue: int32, editMode: bool): int32 {.importc: "GuiValueBox", sideEffect.}
proc valueBoxFloatImpl(bounds: Rectangle, text: cstring, textValue: cstring, value: ptr float32, editMode: bool): int32 {.importc: "GuiValueBoxFloat", sideEffect.}
proc textBoxImpl(bounds: Rectangle, text: cstring, textSize: int32, editMode: bool): int32 {.importc: "GuiTextBox", sideEffect.}
proc sliderImpl(bounds: Rectangle, textLeft: cstring, textRight: cstring, value: out float32, minValue: float32, maxValue: float32): int32 {.importc: "GuiSlider", sideEffect.}
proc sliderBarImpl(bounds: Rectangle, textLeft: cstring, textRight: cstring, value: out float32, minValue: float32, maxValue: float32): int32 {.importc: "GuiSliderBar", sideEffect.}
proc progressBarImpl(bounds: Rectangle, textLeft: cstring, textRight: cstring, value: out float32, minValue: float32, maxValue: float32): int32 {.importc: "GuiProgressBar", sideEffect.}
proc statusBarImpl(bounds: Rectangle, text: cstring): int32 {.importc: "GuiStatusBar", sideEffect.}
proc dummyRecImpl(bounds: Rectangle, text: cstring): int32 {.importc: "GuiDummyRec", sideEffect.}
proc gridImpl(bounds: Rectangle, text: cstring, spacing: float32, subdivs: int32, mouseCell: out Vector2): int32 {.importc: "GuiGrid", sideEffect.}
proc listViewImpl(bounds: Rectangle, text: cstring, scrollIndex: out int32, active: out int32): int32 {.importc: "GuiListView", sideEffect.}
proc listView*(bounds: Rectangle, text: cstringArray, count: int32, scrollIndex: out int32, active: out int32, focus: out int32): int32 {.importc: "GuiListViewEx", sideEffect.}
  ## List View with extended parameters
proc messageBoxImpl(bounds: Rectangle, title: cstring, message: cstring, buttons: cstring): int32 {.importc: "GuiMessageBox", sideEffect.}
proc textInputBoxImpl(bounds: Rectangle, title: cstring, message: cstring, buttons: cstring, text: cstring, textMaxSize: int32, secretViewActive: out bool): int32 {.importc: "GuiTextInputBox", sideEffect.}
proc colorPickerImpl(bounds: Rectangle, text: cstring, color: out Color): int32 {.importc: "GuiColorPicker", sideEffect.}
proc colorPanelImpl(bounds: Rectangle, text: cstring, color: out Color): int32 {.importc: "GuiColorPanel", sideEffect.}
proc colorBarAlphaImpl(bounds: Rectangle, text: cstring, alpha: out float32): int32 {.importc: "GuiColorBarAlpha", sideEffect.}
proc colorBarHueImpl(bounds: Rectangle, text: cstring, value: out float32): int32 {.importc: "GuiColorBarHue", sideEffect.}
proc colorPickerHSVImpl(bounds: Rectangle, text: cstring, colorHsv: out Vector3): int32 {.importc: "GuiColorPickerHSV", sideEffect.}
proc colorPanelHSVImpl(bounds: Rectangle, text: cstring, colorHsv: out Vector3): int32 {.importc: "GuiColorPanelHSV", sideEffect.}
{.pop.}


proc loadStyle*(fileName: string) =
  ## Load style file over global style variable (.rgs)
  loadStyleImpl(fileName.cstring)

proc setTooltip*(tooltip: string) =
  ## Set tooltip string
  setTooltipImpl(tooltip.cstring)

proc iconText*(iconId: GuiIconName, text: string): string =
  ## Get text with icon id prepended (if supported)
  $iconTextImpl(iconId, text.cstring)

proc loadIcons*(fileName: string, loadIconsName: bool): cstringArray =
  ## Load raygui icons file (.rgi) into internal icons data
  loadIconsImpl(fileName.cstring, loadIconsName)

proc windowBox*(bounds: Rectangle, title: string): int32 =
  ## Window Box control, shows a window that can be closed
  windowBoxImpl(bounds, title.cstring)

proc groupBox*(bounds: Rectangle, text: string): int32 =
  ## Group Box control with text name
  groupBoxImpl(bounds, text.cstring)

proc line*(bounds: Rectangle, text: string): int32 =
  ## Line separator control, could contain text
  lineImpl(bounds, text.cstring)

proc panel*(bounds: Rectangle, text: string): int32 =
  ## Panel control, useful to group controls
  panelImpl(bounds, text.cstring)

proc scrollPanel*(bounds: Rectangle, text: string, content: Rectangle, scroll: out Vector2, view: out Rectangle): int32 =
  ## Scroll Panel control
  scrollPanelImpl(bounds, text.cstring, content, scroll, view)

proc label*(bounds: Rectangle, text: string): int32 =
  ## Label control
  labelImpl(bounds, text.cstring)

proc button*(bounds: Rectangle, text: string): int32 =
  ## Button control, returns true when clicked
  buttonImpl(bounds, text.cstring)

proc labelButton*(bounds: Rectangle, text: string): int32 =
  ## Label button control, returns true when clicked
  labelButtonImpl(bounds, text.cstring)

proc toggle*(bounds: Rectangle, text: string, active: out bool): int32 =
  ## Toggle Button control
  toggleImpl(bounds, text.cstring, active)

proc toggleGroup*(bounds: Rectangle, text: string, active: out int32): int32 =
  ## Toggle Group control
  toggleGroupImpl(bounds, text.cstring, active)

proc toggleSlider*(bounds: Rectangle, text: string, active: out int32): int32 =
  ## Toggle Slider control
  toggleSliderImpl(bounds, text.cstring, active)

proc checkBox*(bounds: Rectangle, text: string, checked: var bool): int32 =
  ## Check Box control, returns true when active
  checkBoxImpl(bounds, text.cstring, addr checked)

proc comboBox*(bounds: Rectangle, text: string, active: out int32): int32 =
  ## Combo Box control
  comboBoxImpl(bounds, text.cstring, active)

proc dropdownBox*(bounds: Rectangle, text: string, active: out int32, editMode: bool): int32 =
  ## Dropdown Box control
  dropdownBoxImpl(bounds, text.cstring, active, editMode)

proc spinner*(bounds: Rectangle, text: string, value: out int32, minValue: int32, maxValue: int32, editMode: bool): int32 =
  ## Spinner control
  spinnerImpl(bounds, text.cstring, value, minValue, maxValue, editMode)

proc valueBox*(bounds: Rectangle, text: string, value: out int32, minValue: int32, maxValue: int32, editMode: bool): int32 =
  ## Value Box control, updates input text with numbers
  valueBoxImpl(bounds, text.cstring, value, minValue, maxValue, editMode)

proc valueBoxFloat*(bounds: Rectangle, text: string, textValue: string, value: var float32, editMode: bool): int32 =
  ## Value box control for float values
  valueBoxFloatImpl(bounds, text.cstring, textValue.cstring, addr value, editMode)

proc textBox*(bounds: Rectangle, text: string, textSize: int32, editMode: bool): int32 =
  ## Text Box control, updates input text
  textBoxImpl(bounds, text.cstring, textSize, editMode)

proc slider*(bounds: Rectangle, textLeft: string, textRight: string, value: out float32, minValue: float32, maxValue: float32): int32 =
  ## Slider control
  sliderImpl(bounds, textLeft.cstring, textRight.cstring, value, minValue, maxValue)

proc sliderBar*(bounds: Rectangle, textLeft: string, textRight: string, value: out float32, minValue: float32, maxValue: float32): int32 =
  ## Slider Bar control
  sliderBarImpl(bounds, textLeft.cstring, textRight.cstring, value, minValue, maxValue)

proc progressBar*(bounds: Rectangle, textLeft: string, textRight: string, value: out float32, minValue: float32, maxValue: float32): int32 =
  ## Progress Bar control
  progressBarImpl(bounds, textLeft.cstring, textRight.cstring, value, minValue, maxValue)

proc statusBar*(bounds: Rectangle, text: string): int32 =
  ## Status Bar control, shows info text
  statusBarImpl(bounds, text.cstring)

proc dummyRec*(bounds: Rectangle, text: string): int32 =
  ## Dummy control for placeholders
  dummyRecImpl(bounds, text.cstring)

proc grid*(bounds: Rectangle, text: string, spacing: float32, subdivs: int32, mouseCell: out Vector2): int32 =
  ## Grid control
  gridImpl(bounds, text.cstring, spacing, subdivs, mouseCell)

proc listView*(bounds: Rectangle, text: string, scrollIndex: out int32, active: out int32): int32 =
  ## List View control
  listViewImpl(bounds, text.cstring, scrollIndex, active)

proc messageBox*(bounds: Rectangle, title: string, message: string, buttons: string): int32 =
  ## Message Box control, displays a message
  messageBoxImpl(bounds, title.cstring, message.cstring, buttons.cstring)

proc textInputBox*(bounds: Rectangle, title: string, message: string, buttons: string, text: string, textMaxSize: int32, secretViewActive: out bool): int32 =
  ## Text Input Box control, ask for text, supports secret
  textInputBoxImpl(bounds, title.cstring, message.cstring, buttons.cstring, text.cstring, textMaxSize, secretViewActive)

proc colorPicker*(bounds: Rectangle, text: string, color: out Color): int32 =
  ## Color Picker control (multiple color controls)
  colorPickerImpl(bounds, text.cstring, color)

proc colorPanel*(bounds: Rectangle, text: string, color: out Color): int32 =
  ## Color Panel control
  colorPanelImpl(bounds, text.cstring, color)

proc colorBarAlpha*(bounds: Rectangle, text: string, alpha: out float32): int32 =
  ## Color Bar Alpha control
  colorBarAlphaImpl(bounds, text.cstring, alpha)

proc colorBarHue*(bounds: Rectangle, text: string, value: out float32): int32 =
  ## Color Bar Hue control
  colorBarHueImpl(bounds, text.cstring, value)

proc colorPickerHSV*(bounds: Rectangle, text: string, colorHsv: out Vector3): int32 =
  ## Color Picker control that avoids conversion to RGB on each call (multiple color controls)
  colorPickerHSVImpl(bounds, text.cstring, colorHsv)

proc colorPanelHSV*(bounds: Rectangle, text: string, colorHsv: out Vector3): int32 =
  ## Color Panel control that updates Hue-Saturation-Value color value, used by GuiColorPickerHSV()
  colorPanelHSVImpl(bounds, text.cstring, colorHsv)
