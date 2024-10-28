from raylib import Vector2, Vector3, Color, Rectangle, Texture2D, Image, GlyphInfo, Font
export Vector2, Vector3, Color, Rectangle, Texture2D, Image, GlyphInfo, Font

import std/paths
const rayguiDir = currentSourcePath().Path.parentDir / Path"raygui/src"

{.passC: "-I" & rayguiDir.}
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

  GuiControlProperty* {.size: sizeof(int32).} = enum ## Gui base properties for every control
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

  GuiDefaultProperty* {.size: sizeof(int32).} = enum ## DEFAULT extended properties
    TextSize = 16 ## Text size (glyphs max height)
    TextSpacing ## Text spacing between glyphs
    LineColor ## Line control color
    BackgroundColor ## Background color
    TextLineSpacing ## Text spacing between lines
    TextAlignmentVertical ## Text vertical alignment inside text bounds (after border and padding)
    TextWrapMode ## Text wrap-mode inside text bounds

  GuiToggleProperty* {.size: sizeof(int32).} = enum ## Toggle/ToggleGroup
    GroupPadding = 16 ## ToggleGroup separation between toggles

  GuiSliderProperty* {.size: sizeof(int32).} = enum ## Slider/SliderBar
    SliderWidth = 16 ## Slider size of internal bar
    SliderPadding ## Slider/SliderBar internal bar padding

  GuiProgressBarProperty* {.size: sizeof(int32).} = enum ## ProgressBar
    ProgressPadding = 16 ## ProgressBar internal padding

  GuiScrollBarProperty* {.size: sizeof(int32).} = enum ## ScrollBar
    ArrowsSize = 16 ## ScrollBar arrows size
    ArrowsVisible ## ScrollBar arrows visible
    ScrollSliderPadding ## ScrollBar slider internal padding
    ScrollSliderSize ## ScrollBar slider size
    ScrollPadding ## ScrollBar scroll padding from arrows
    ScrollSpeed ## ScrollBar scrolling speed

  GuiCheckBoxProperty* {.size: sizeof(int32).} = enum ## CheckBox
    CheckPadding = 16 ## CheckBox internal check padding

  GuiComboBoxProperty* {.size: sizeof(int32).} = enum ## ComboBox
    ComboButtonWidth = 16 ## ComboBox right button width
    ComboButtonSpacing ## ComboBox button separation

  GuiDropdownBoxProperty* {.size: sizeof(int32).} = enum ## DropdownBox
    ArrowPadding = 16 ## DropdownBox arrow separation from border and items
    DropdownItemsSpacing ## DropdownBox items separation
    DropdownArrowHidden ## DropdownBox arrow hidden
    DropdownRollUp ## DropdownBox roll up flag (default rolls down)

  GuiTextBoxProperty* {.size: sizeof(int32).} = enum ## TextBox/TextBoxMulti/ValueBox/Spinner
    TextReadonly = 16 ## TextBox in read-only mode: 0-text editable, 1-text no-editable

  GuiSpinnerProperty* {.size: sizeof(int32).} = enum ## Spinner
    SpinButtonWidth = 16 ## Spinner left/right buttons width
    SpinButtonSpacing ## Spinner buttons separation

  GuiListViewProperty* {.size: sizeof(int32).} = enum ## ListView
    ListItemsHeight = 16 ## ListView items height
    ListItemsSpacing ## ListView items separation
    ScrollbarWidth ## ListView scrollbar size (usually width)
    ScrollbarSide ## ListView scrollbar side (0-SCROLLBAR_LEFT_SIDE, 1-SCROLLBAR_RIGHT_SIDE)
    ListItemsBorderWidth ## ListView items border width

  GuiColorPickerProperty* {.size: sizeof(int32).} = enum ## ColorPicker
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
  GuiStyleProp* {.importc, header: "raygui.h", completeStruct, bycopy.} = object ## NOTE: Used when exporting style as code for convenience
    controlId*: uint16 ## Control identifier
    propertyId*: uint16 ## Property identifier
    propertyValue*: int32 ## Property value

  GuiTextStyle* {.importc, header: "raygui.h", completeStruct, bycopy.} = object ## NOTE: Text style is defined by control
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
proc guiSetState*(state: int32) {.importc: "GuiSetState", sideEffect.}
  ## Set gui state (global state)
proc guiGetState*(): int32 {.importc: "GuiGetState", sideEffect.}
  ## Get gui state (global state)
proc guiSetFont*(font: Font) {.importc: "GuiSetFont", sideEffect.}
  ## Set gui custom font (global state)
proc guiGetFont*(): Font {.importc: "GuiGetFont", sideEffect.}
  ## Get gui custom font (global state)
proc guiSetStyle*(control: int32, property: int32, value: int32) {.importc: "GuiSetStyle", sideEffect.}
  ## Set one style property
proc guiGetStyle*(control: int32, property: int32): int32 {.importc: "GuiGetStyle", sideEffect.}
  ## Get one style property
proc guiLoadStyleImpl(fileName: cstring) {.importc: "GuiLoadStyle", sideEffect.}
proc guiLoadStyleDefault*() {.importc: "GuiLoadStyleDefault", sideEffect.}
  ## Load style default over global style
proc guiEnableTooltip*() {.importc: "GuiEnableTooltip", sideEffect.}
  ## Enable gui tooltips (global state)
proc guiDisableTooltip*() {.importc: "GuiDisableTooltip", sideEffect.}
  ## Disable gui tooltips (global state)
proc guiSetTooltipImpl(tooltip: cstring) {.importc: "GuiSetTooltip", sideEffect.}
proc guiIconTextImpl(iconId: int32, text: cstring): cstring {.importc: "GuiIconText", sideEffect.}
proc guiSetIconScale*(scale: int32) {.importc: "GuiSetIconScale", sideEffect.}
  ## Set default icon drawing size
proc guiGetIcons*(): var uint32 {.importc: "GuiGetIcons", sideEffect.}
  ## Get raygui icons data pointer
proc guiLoadIconsImpl(fileName: cstring, loadIconsName: bool): cstringArray {.importc: "GuiLoadIcons", sideEffect.}
proc guiDrawIcon*(iconId: int32, posX: int32, posY: int32, pixelSize: int32, color: Color) {.importc: "GuiDrawIcon", sideEffect.}
  ## Draw icon using pixel size at specified position
proc guiWindowBoxImpl(bounds: Rectangle, title: cstring): int32 {.importc: "GuiWindowBox", sideEffect.}
proc guiGroupBoxImpl(bounds: Rectangle, text: cstring): int32 {.importc: "GuiGroupBox", sideEffect.}
proc guiLineImpl(bounds: Rectangle, text: cstring): int32 {.importc: "GuiLine", sideEffect.}
proc guiPanelImpl(bounds: Rectangle, text: cstring): int32 {.importc: "GuiPanel", sideEffect.}
proc guiTabBar*(bounds: Rectangle, text: cstringArray, count: int32, active: out int32): int32 {.importc: "GuiTabBar", sideEffect.}
  ## Tab Bar control, returns TAB to be closed or -1
proc guiScrollPanelImpl(bounds: Rectangle, text: cstring, content: Rectangle, scroll: out Vector2, view: out Rectangle): int32 {.importc: "GuiScrollPanel", sideEffect.}
proc guiLabelImpl(bounds: Rectangle, text: cstring): int32 {.importc: "GuiLabel", sideEffect.}
proc guiButtonImpl(bounds: Rectangle, text: cstring): int32 {.importc: "GuiButton", sideEffect.}
proc guiLabelButtonImpl(bounds: Rectangle, text: cstring): int32 {.importc: "GuiLabelButton", sideEffect.}
proc guiToggleImpl(bounds: Rectangle, text: cstring, active: out bool): int32 {.importc: "GuiToggle", sideEffect.}
proc guiToggleGroupImpl(bounds: Rectangle, text: cstring, active: out int32): int32 {.importc: "GuiToggleGroup", sideEffect.}
proc guiToggleSliderImpl(bounds: Rectangle, text: cstring, active: out int32): int32 {.importc: "GuiToggleSlider", sideEffect.}
proc guiCheckBoxImpl(bounds: Rectangle, text: cstring, checked: ptr bool): int32 {.importc: "GuiCheckBox", sideEffect.}
proc guiComboBoxImpl(bounds: Rectangle, text: cstring, active: out int32): int32 {.importc: "GuiComboBox", sideEffect.}
proc guiDropdownBoxImpl(bounds: Rectangle, text: cstring, active: out int32, editMode: bool): int32 {.importc: "GuiDropdownBox", sideEffect.}
proc guiSpinnerImpl(bounds: Rectangle, text: cstring, value: out int32, minValue: int32, maxValue: int32, editMode: bool): int32 {.importc: "GuiSpinner", sideEffect.}
proc guiValueBoxImpl(bounds: Rectangle, text: cstring, value: out int32, minValue: int32, maxValue: int32, editMode: bool): int32 {.importc: "GuiValueBox", sideEffect.}
proc guiValueBoxFloatImpl(bounds: Rectangle, text: cstring, textValue: cstring, value: ptr float32, editMode: bool): int32 {.importc: "GuiValueBoxFloat", sideEffect.}
proc guiTextBoxImpl(bounds: Rectangle, text: cstring, textSize: int32, editMode: bool): int32 {.importc: "GuiTextBox", sideEffect.}
proc guiSliderImpl(bounds: Rectangle, textLeft: cstring, textRight: cstring, value: out float32, minValue: float32, maxValue: float32): int32 {.importc: "GuiSlider", sideEffect.}
proc guiSliderBarImpl(bounds: Rectangle, textLeft: cstring, textRight: cstring, value: out float32, minValue: float32, maxValue: float32): int32 {.importc: "GuiSliderBar", sideEffect.}
proc guiProgressBarImpl(bounds: Rectangle, textLeft: cstring, textRight: cstring, value: out float32, minValue: float32, maxValue: float32): int32 {.importc: "GuiProgressBar", sideEffect.}
proc guiStatusBarImpl(bounds: Rectangle, text: cstring): int32 {.importc: "GuiStatusBar", sideEffect.}
proc guiDummyRecImpl(bounds: Rectangle, text: cstring): int32 {.importc: "GuiDummyRec", sideEffect.}
proc guiGridImpl(bounds: Rectangle, text: cstring, spacing: float32, subdivs: int32, mouseCell: out Vector2): int32 {.importc: "GuiGrid", sideEffect.}
proc guiListViewImpl(bounds: Rectangle, text: cstring, scrollIndex: out int32, active: out int32): int32 {.importc: "GuiListView", sideEffect.}
proc guiListView*(bounds: Rectangle, text: cstringArray, count: int32, scrollIndex: out int32, active: out int32, focus: out int32): int32 {.importc: "GuiListViewEx", sideEffect.}
  ## List View with extended parameters
proc guiMessageBoxImpl(bounds: Rectangle, title: cstring, message: cstring, buttons: cstring): int32 {.importc: "GuiMessageBox", sideEffect.}
proc guiTextInputBoxImpl(bounds: Rectangle, title: cstring, message: cstring, buttons: cstring, text: cstring, textMaxSize: int32, secretViewActive: out bool): int32 {.importc: "GuiTextInputBox", sideEffect.}
proc guiColorPickerImpl(bounds: Rectangle, text: cstring, color: out Color): int32 {.importc: "GuiColorPicker", sideEffect.}
proc guiColorPanelImpl(bounds: Rectangle, text: cstring, color: out Color): int32 {.importc: "GuiColorPanel", sideEffect.}
proc guiColorBarAlphaImpl(bounds: Rectangle, text: cstring, alpha: out float32): int32 {.importc: "GuiColorBarAlpha", sideEffect.}
proc guiColorBarHueImpl(bounds: Rectangle, text: cstring, value: out float32): int32 {.importc: "GuiColorBarHue", sideEffect.}
proc guiColorPickerHSVImpl(bounds: Rectangle, text: cstring, colorHsv: out Vector3): int32 {.importc: "GuiColorPickerHSV", sideEffect.}
proc guiColorPanelHSVImpl(bounds: Rectangle, text: cstring, colorHsv: out Vector3): int32 {.importc: "GuiColorPanelHSV", sideEffect.}
{.pop.}


proc guiLoadStyle*(fileName: string) =
  ## Load style file over global style variable (.rgs)
  guiLoadStyleImpl(fileName.cstring)

proc guiSetTooltip*(tooltip: string) =
  ## Set tooltip string
  guiSetTooltipImpl(tooltip.cstring)

proc guiIconText*(iconId: int32, text: string): string =
  ## Get text with icon id prepended (if supported)
  $guiIconTextImpl(iconId, text.cstring)

proc guiLoadIcons*(fileName: string, loadIconsName: bool): cstringArray =
  ## Load raygui icons file (.rgi) into internal icons data
  guiLoadIconsImpl(fileName.cstring, loadIconsName)

proc guiWindowBox*(bounds: Rectangle, title: string): int32 =
  ## Window Box control, shows a window that can be closed
  guiWindowBoxImpl(bounds, title.cstring)

proc guiGroupBox*(bounds: Rectangle, text: string): int32 =
  ## Group Box control with text name
  guiGroupBoxImpl(bounds, text.cstring)

proc guiLine*(bounds: Rectangle, text: string): int32 =
  ## Line separator control, could contain text
  guiLineImpl(bounds, text.cstring)

proc guiPanel*(bounds: Rectangle, text: string): int32 =
  ## Panel control, useful to group controls
  guiPanelImpl(bounds, text.cstring)

proc guiScrollPanel*(bounds: Rectangle, text: string, content: Rectangle, scroll: out Vector2, view: out Rectangle): int32 =
  ## Scroll Panel control
  guiScrollPanelImpl(bounds, text.cstring, content, scroll, view)

proc guiLabel*(bounds: Rectangle, text: string): int32 =
  ## Label control
  guiLabelImpl(bounds, text.cstring)

proc guiButton*(bounds: Rectangle, text: string): int32 =
  ## Button control, returns true when clicked
  guiButtonImpl(bounds, text.cstring)

proc guiLabelButton*(bounds: Rectangle, text: string): int32 =
  ## Label button control, returns true when clicked
  guiLabelButtonImpl(bounds, text.cstring)

proc guiToggle*(bounds: Rectangle, text: string, active: out bool): int32 =
  ## Toggle Button control
  guiToggleImpl(bounds, text.cstring, active)

proc guiToggleGroup*(bounds: Rectangle, text: string, active: out int32): int32 =
  ## Toggle Group control
  guiToggleGroupImpl(bounds, text.cstring, active)

proc guiToggleSlider*(bounds: Rectangle, text: string, active: out int32): int32 =
  ## Toggle Slider control
  guiToggleSliderImpl(bounds, text.cstring, active)

proc guiCheckBox*(bounds: Rectangle, text: string, checked: var bool): int32 =
  ## Check Box control, returns true when active
  guiCheckBoxImpl(bounds, text.cstring, addr checked)

proc guiComboBox*(bounds: Rectangle, text: string, active: out int32): int32 =
  ## Combo Box control
  guiComboBoxImpl(bounds, text.cstring, active)

proc guiDropdownBox*(bounds: Rectangle, text: string, active: out int32, editMode: bool): int32 =
  ## Dropdown Box control
  guiDropdownBoxImpl(bounds, text.cstring, active, editMode)

proc guiSpinner*(bounds: Rectangle, text: string, value: out int32, minValue: int32, maxValue: int32, editMode: bool): int32 =
  ## Spinner control
  guiSpinnerImpl(bounds, text.cstring, value, minValue, maxValue, editMode)

proc guiValueBox*(bounds: Rectangle, text: string, value: out int32, minValue: int32, maxValue: int32, editMode: bool): int32 =
  ## Value Box control, updates input text with numbers
  guiValueBoxImpl(bounds, text.cstring, value, minValue, maxValue, editMode)

proc guiValueBoxFloat*(bounds: Rectangle, text: string, textValue: string, value: var float32, editMode: bool): int32 =
  ## Value box control for float values
  guiValueBoxFloatImpl(bounds, text.cstring, textValue.cstring, addr value, editMode)

proc guiTextBox*(bounds: Rectangle, text: string, textSize: int32, editMode: bool): int32 =
  ## Text Box control, updates input text
  guiTextBoxImpl(bounds, text.cstring, textSize, editMode)

proc guiSlider*(bounds: Rectangle, textLeft: string, textRight: string, value: out float32, minValue: float32, maxValue: float32): int32 =
  ## Slider control
  guiSliderImpl(bounds, textLeft.cstring, textRight.cstring, value, minValue, maxValue)

proc guiSliderBar*(bounds: Rectangle, textLeft: string, textRight: string, value: out float32, minValue: float32, maxValue: float32): int32 =
  ## Slider Bar control
  guiSliderBarImpl(bounds, textLeft.cstring, textRight.cstring, value, minValue, maxValue)

proc guiProgressBar*(bounds: Rectangle, textLeft: string, textRight: string, value: out float32, minValue: float32, maxValue: float32): int32 =
  ## Progress Bar control
  guiProgressBarImpl(bounds, textLeft.cstring, textRight.cstring, value, minValue, maxValue)

proc guiStatusBar*(bounds: Rectangle, text: string): int32 =
  ## Status Bar control, shows info text
  guiStatusBarImpl(bounds, text.cstring)

proc guiDummyRec*(bounds: Rectangle, text: string): int32 =
  ## Dummy control for placeholders
  guiDummyRecImpl(bounds, text.cstring)

proc guiGrid*(bounds: Rectangle, text: string, spacing: float32, subdivs: int32, mouseCell: out Vector2): int32 =
  ## Grid control
  guiGridImpl(bounds, text.cstring, spacing, subdivs, mouseCell)

proc guiListView*(bounds: Rectangle, text: string, scrollIndex: out int32, active: out int32): int32 =
  ## List View control
  guiListViewImpl(bounds, text.cstring, scrollIndex, active)

proc guiMessageBox*(bounds: Rectangle, title: string, message: string, buttons: string): int32 =
  ## Message Box control, displays a message
  guiMessageBoxImpl(bounds, title.cstring, message.cstring, buttons.cstring)

proc guiTextInputBox*(bounds: Rectangle, title: string, message: string, buttons: string, text: string, textMaxSize: int32, secretViewActive: out bool): int32 =
  ## Text Input Box control, ask for text, supports secret
  guiTextInputBoxImpl(bounds, title.cstring, message.cstring, buttons.cstring, text.cstring, textMaxSize, secretViewActive)

proc guiColorPicker*(bounds: Rectangle, text: string, color: out Color): int32 =
  ## Color Picker control (multiple color controls)
  guiColorPickerImpl(bounds, text.cstring, color)

proc guiColorPanel*(bounds: Rectangle, text: string, color: out Color): int32 =
  ## Color Panel control
  guiColorPanelImpl(bounds, text.cstring, color)

proc guiColorBarAlpha*(bounds: Rectangle, text: string, alpha: out float32): int32 =
  ## Color Bar Alpha control
  guiColorBarAlphaImpl(bounds, text.cstring, alpha)

proc guiColorBarHue*(bounds: Rectangle, text: string, value: out float32): int32 =
  ## Color Bar Hue control
  guiColorBarHueImpl(bounds, text.cstring, value)

proc guiColorPickerHSV*(bounds: Rectangle, text: string, colorHsv: out Vector3): int32 =
  ## Color Picker control that avoids conversion to RGB on each call (multiple color controls)
  guiColorPickerHSVImpl(bounds, text.cstring, colorHsv)

proc guiColorPanelHSV*(bounds: Rectangle, text: string, colorHsv: out Vector3): int32 =
  ## Color Panel control that updates Hue-Saturation-Value color value, used by GuiColorPickerHSV()
  guiColorPanelHSVImpl(bounds, text.cstring, colorHsv)
