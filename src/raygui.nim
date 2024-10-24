from raylib import Vector2, Vector3, Color, Rectangle, Texture2D, Image, GlyphInfo, Font
export Vector2, Vector3, Color, Rectangle, Texture2D, Image, GlyphInfo, Font

import std/os
const rayguiDir = currentSourcePath().parentDir / "raygui/src"

{.passC: "-I" & rayguiDir.}
{.passC: "-DRAYGUI_IMPLEMENTATION".}

const
  RayguiVersion* = (4, 0, 0)

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
    IconBox
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
    IconPot
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
    IconBin
    HandPointer
    Laser
    Coin
    Explosion
    Icon1up
    Player
    PlayerJump
    IconKey
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
    IconHex
    Shield
    FileNew
    FolderAdd
    Alarm
    IconCpu
    IconRom
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
    Icon220
    Icon221
    Icon222
    Icon223
    Icon224
    Icon225
    Icon226
    Icon227
    Icon228
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
  GuiStyleProp* {.bycopy.} = object ## NOTE: Used when exporting style as code for convenience
    controlId*: uint16 ## Control identifier
    propertyId*: uint16 ## Property identifier
    propertyValue*: int32 ## Property value

  GuiTextStyle* {.bycopy.} = object ## NOTE: Text style is defined by control
    size*: uint32
    charSpacing*: int32
    lineSpacing*: int32
    alignmentH*: int32
    alignmentV*: int32
    padding*: int32

{.push callconv: cdecl, header: "raygui.h".}
proc guiEnable*() {.importc: "GuiEnable".}
  ## Enable gui controls (global state)
proc guiDisable*() {.importc: "GuiDisable".}
  ## Disable gui controls (global state)
proc guiLock*() {.importc: "GuiLock".}
  ## Lock gui controls (global state)
proc guiUnlock*() {.importc: "GuiUnlock".}
  ## Unlock gui controls (global state)
proc guiIsLocked*(): bool {.importc: "GuiIsLocked".}
  ## Check if gui is locked (global state)
proc guiSetAlpha*(alpha: float32) {.importc: "GuiSetAlpha".}
  ## Set gui controls alpha (global state), alpha goes from 0.0f to 1.0f
proc guiSetState*(state: GuiState) {.importc: "GuiSetState".}
  ## Set gui state (global state)
proc guiGetState*(): GuiState {.importc: "GuiGetState".}
  ## Get gui state (global state)
proc guiSetFont*(font: Font) {.importc: "GuiSetFont".}
  ## Set gui custom font (global state)
proc guiGetFont*(): Font {.importc: "GuiGetFont".}
  ## Get gui custom font (global state)
proc guiSetStyle*(control: GuiControl, property: int32, value: int32) {.importc: "GuiSetStyle".}
  ## Set one style property
proc guiGetStyle*(control: GuiControl, property: int32): int32 {.importc: "GuiGetStyle".}
  ## Get one style property
proc guiLoadStyle*(fileName: cstring) {.importc: "GuiLoadStyle".}
  ## Load style file over global style variable (.rgs)
proc guiLoadStyleDefault*() {.importc: "GuiLoadStyleDefault".}
  ## Load style default over global style
proc guiEnableTooltip*() {.importc: "GuiEnableTooltip".}
  ## Enable gui tooltips (global state)
proc guiDisableTooltip*() {.importc: "GuiDisableTooltip".}
  ## Disable gui tooltips (global state)
proc guiSetTooltip*(tooltip: cstring) {.importc: "GuiSetTooltip".}
  ## Set tooltip string
proc guiIconText*(iconId: GuiIconName, text: cstring): cstring {.importc: "GuiIconText".}
  ## Get text with icon id prepended (if supported)
proc guiSetIconScale*(scale: int32) {.importc: "GuiSetIconScale".}
  ## Set default icon drawing size
proc guiGetIcons*(): var uint32 {.importc: "GuiGetIcons".}
  ## Get raygui icons data pointer
proc guiLoadIcons*(fileName: cstring, loadIconsName: bool): cstringArray {.importc: "GuiLoadIcons".}
  ## Load raygui icons file (.rgi) into internal icons data
proc guiDrawIcon*(iconId: GuiIconName, posX: int32, posY: int32, pixelSize: int32, color: Color) {.importc: "GuiDrawIcon".}
  ## Draw icon using pixel size at specified position
proc guiWindowBox*(bounds: Rectangle, title: cstring): int32 {.importc: "GuiWindowBox".}
  ## Window Box control, shows a window that can be closed
proc guiGroupBox*(bounds: Rectangle, text: cstring): int32 {.importc: "GuiGroupBox".}
  ## Group Box control with text name
proc guiLine*(bounds: Rectangle, text: cstring): int32 {.importc: "GuiLine".}
  ## Line separator control, could contain text
proc guiPanel*(bounds: Rectangle, text: cstring): int32 {.importc: "GuiPanel".}
  ## Panel control, useful to group controls
proc guiTabBar*(bounds: Rectangle, text: cstringArray, count: int32, active: out int32): int32 {.importc: "GuiTabBar".}
  ## Tab Bar control, returns TAB to be closed or -1
proc guiScrollPanel*(bounds: Rectangle, text: cstring, content: Rectangle, scroll: out Vector2, view: out Rectangle): int32 {.importc: "GuiScrollPanel".}
  ## Scroll Panel control
proc guiLabel*(bounds: Rectangle, text: cstring): int32 {.importc: "GuiLabel".}
  ## Label control, shows text
proc guiButton*(bounds: Rectangle, text: cstring): int32 {.importc: "GuiButton".}
  ## Button control, returns true when clicked
proc guiLabelButton*(bounds: Rectangle, text: cstring): int32 {.importc: "GuiLabelButton".}
  ## Label button control, show true when clicked
proc guiToggle*(bounds: Rectangle, text: cstring, active: out bool): int32 {.importc: "GuiToggle".}
  ## Toggle Button control, returns true when active
proc guiToggleGroup*(bounds: Rectangle, text: cstring, active: out int32): int32 {.importc: "GuiToggleGroup".}
  ## Toggle Group control, returns active toggle index
proc guiToggleSlider*(bounds: Rectangle, text: cstring, active: out int32): int32 {.importc: "GuiToggleSlider".}
  ## Toggle Slider control, returns true when clicked
proc guiCheckBox*(bounds: Rectangle, text: cstring, checked: out bool): int32 {.importc: "GuiCheckBox".}
  ## Check Box control, returns true when active
proc guiComboBox*(bounds: Rectangle, text: cstring, active: out int32): int32 {.importc: "GuiComboBox".}
  ## Combo Box control, returns selected item index
proc guiDropdownBox*(bounds: Rectangle, text: cstring, active: out int32, editMode: bool): int32 {.importc: "GuiDropdownBox".}
  ## Dropdown Box control, returns selected item
proc guiSpinner*(bounds: Rectangle, text: cstring, value: out int32, minValue: int32, maxValue: int32, editMode: bool): int32 {.importc: "GuiSpinner".}
  ## Spinner control, returns selected value
proc guiValueBox*(bounds: Rectangle, text: cstring, value: out int32, minValue: int32, maxValue: int32, editMode: bool): int32 {.importc: "GuiValueBox".}
  ## Value Box control, updates input text with numbers
proc guiTextBox*(bounds: Rectangle, text: cstring, textSize: int32, editMode: bool): int32 {.importc: "GuiTextBox".}
  ## Text Box control, updates input text
proc guiSlider*(bounds: Rectangle, textLeft: cstring, textRight: cstring, value: out float32, minValue: float32, maxValue: float32): int32 {.importc: "GuiSlider".}
  ## Slider control, returns selected value
proc guiSliderBar*(bounds: Rectangle, textLeft: cstring, textRight: cstring, value: out float32, minValue: float32, maxValue: float32): int32 {.importc: "GuiSliderBar".}
  ## Slider Bar control, returns selected value
proc guiProgressBar*(bounds: Rectangle, textLeft: cstring, textRight: cstring, value: out float32, minValue: float32, maxValue: float32): int32 {.importc: "GuiProgressBar".}
  ## Progress Bar control, shows current progress value
proc guiStatusBar*(bounds: Rectangle, text: cstring): int32 {.importc: "GuiStatusBar".}
  ## Status Bar control, shows info text
proc guiDummyRec*(bounds: Rectangle, text: cstring): int32 {.importc: "GuiDummyRec".}
  ## Dummy control for placeholders
proc guiGrid*(bounds: Rectangle, text: cstring, spacing: float32, subdivs: int32, mouseCell: out Vector2): int32 {.importc: "GuiGrid".}
  ## Grid control, returns mouse cell position
proc guiListView*(bounds: Rectangle, text: cstring, scrollIndex: out int32, active: out int32): int32 {.importc: "GuiListView".}
  ## List View control, returns selected list item index
proc guiListView*(bounds: Rectangle, text: cstringArray, count: int32, scrollIndex: out int32, active: out int32, focus: out int32): int32 {.importc: "GuiListViewEx".}
  ## List View with extended parameters
proc guiMessageBox*(bounds: Rectangle, title: cstring, message: cstring, buttons: cstring): int32 {.importc: "GuiMessageBox".}
  ## Message Box control, displays a message
proc guiTextInputBox*(bounds: Rectangle, title: cstring, message: cstring, buttons: cstring, text: cstring, textMaxSize: int32, secretViewActive: out bool): int32 {.importc: "GuiTextInputBox".}
  ## Text Input Box control, ask for text, supports secret
proc guiColorPicker*(bounds: Rectangle, text: cstring, color: out Color): int32 {.importc: "GuiColorPicker".}
  ## Color Picker control (multiple color controls)
proc guiColorPanel*(bounds: Rectangle, text: cstring, color: out Color): int32 {.importc: "GuiColorPanel".}
  ## Color Panel control
proc guiColorBarAlpha*(bounds: Rectangle, text: cstring, alpha: out float32): int32 {.importc: "GuiColorBarAlpha".}
  ## Color Bar Alpha control
proc guiColorBarHue*(bounds: Rectangle, text: cstring, value: out float32): int32 {.importc: "GuiColorBarHue".}
  ## Color Bar Hue control
proc guiColorPickerHSV*(bounds: Rectangle, text: cstring, colorHsv: out Vector3): int32 {.importc: "GuiColorPickerHSV".}
  ## Color Picker control that avoids conversion to RGB on each call (multiple color controls)
proc guiColorPanelHSV*(bounds: Rectangle, text: cstring, colorHsv: out Vector3): int32 {.importc: "GuiColorPanelHSV".}
  ## Color Panel control that returns HSV color value, used by GuiColorPickerHSV()
