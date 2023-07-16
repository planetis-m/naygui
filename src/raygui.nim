from raylib import Vector2, Vector3, Color, Rectangle, Texture2D, Image, GlyphInfo, Font
export Vector2, Vector3, Color, Rectangle, Texture2D, Image, GlyphInfo, Font

type
  GuiStyleProp* {.bycopy.} = object ## Style property
    controlId*: uint16
    propertyId*: uint16
    propertyValue*: uint32

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
proc guiFade*(alpha: float32) {.importc: "GuiFade".}
  ## Set gui controls alpha (global state), alpha goes from 0.0f to 1.0f
proc guiSetState*(state: int32) {.importc: "GuiSetState".}
  ## Set gui state (global state)
proc guiGetState*(): int32 {.importc: "GuiGetState".}
  ## Get gui state (global state)
proc guiSetFont*(font: Font) {.importc: "GuiSetFont".}
  ## Set gui custom font (global state)
proc guiGetFont*(): Font {.importc: "GuiGetFont".}
  ## Get gui custom font (global state)
proc guiSetStyle*(control: int32, property: int32, value: int32) {.importc: "GuiSetStyle".}
  ## Set one style property
proc guiGetStyle*(control: int32, property: int32): int32 {.importc: "GuiGetStyle".}
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
proc guiIconText*(iconId: int32, text: cstring): cstring {.importc: "GuiIconText".}
  ## Get text with icon id prepended (if supported)
proc guiSetIconScale*(scale: int32) {.importc: "GuiSetIconScale".}
  ## Set default icon drawing size
proc guiGetIcons*(): var uint32 {.importc: "GuiGetIcons".}
  ## Get raygui icons data pointer
proc guiLoadIcons*(fileName: cstring, loadIconsName: bool): cstringArray {.importc: "GuiLoadIcons".}
  ## Load raygui icons file (.rgi) into internal icons data
proc guiDrawIcon*(iconId: int32, posX: int32, posY: int32, pixelSize: int32, color: Color) {.importc: "GuiDrawIcon".}
  ## Draw icon using pixel size at specified position
proc guiWindowBox*(bounds: Rectangle, title: cstring): int32 {.importc: "GuiWindowBox".}
  ## Window Box control, shows a window that can be closed
proc guiGroupBox*(bounds: Rectangle, text: cstring): int32 {.importc: "GuiGroupBox".}
  ## Group Box control with text name
proc guiLine*(bounds: Rectangle, text: cstring): int32 {.importc: "GuiLine".}
  ## Line separator control, could contain text
proc guiPanel*(bounds: Rectangle, text: cstring): int32 {.importc: "GuiPanel".}
  ## Panel control, useful to group controls
proc guiTabBar*(bounds: Rectangle, text: cstringArray, count: int32, active: var int32): int32 {.importc: "GuiTabBar".}
  ## Tab Bar control, returns TAB to be closed or -1
proc guiScrollPanel*(bounds: Rectangle, text: cstring, content: Rectangle, scroll: var Vector2, view: var Rectangle): int32 {.importc: "GuiScrollPanel".}
  ## Scroll Panel control
proc guiLabel*(bounds: Rectangle, text: cstring): int32 {.importc: "GuiLabel".}
  ## Label control, shows text
proc guiButton*(bounds: Rectangle, text: cstring): int32 {.importc: "GuiButton".}
  ## Button control, returns true when clicked
proc guiLabelButton*(bounds: Rectangle, text: cstring): int32 {.importc: "GuiLabelButton".}
  ## Label button control, show true when clicked
proc guiToggle*(bounds: Rectangle, text: cstring, active: var bool): int32 {.importc: "GuiToggle".}
  ## Toggle Button control, returns true when active
proc guiToggleGroup*(bounds: Rectangle, text: cstring, active: var int32): int32 {.importc: "GuiToggleGroup".}
  ## Toggle Group control, returns active toggle index
proc guiCheckBox*(bounds: Rectangle, text: cstring, checked: var bool): int32 {.importc: "GuiCheckBox".}
  ## Check Box control, returns true when active
proc guiComboBox*(bounds: Rectangle, text: cstring, active: var int32): int32 {.importc: "GuiComboBox".}
  ## Combo Box control, returns selected item index
proc guiDropdownBox*(bounds: Rectangle, text: cstring, active: var int32, editMode: bool): int32 {.importc: "GuiDropdownBox".}
  ## Dropdown Box control, returns selected item
proc guiSpinner*(bounds: Rectangle, text: cstring, value: var int32, minValue: int32, maxValue: int32, editMode: bool): int32 {.importc: "GuiSpinner".}
  ## Spinner control, returns selected value
proc guiValueBox*(bounds: Rectangle, text: cstring, value: var int32, minValue: int32, maxValue: int32, editMode: bool): int32 {.importc: "GuiValueBox".}
  ## Value Box control, updates input text with numbers
proc guiTextBox*(bounds: Rectangle, text: cstring, textSize: int32, editMode: bool): int32 {.importc: "GuiTextBox".}
  ## Text Box control, updates input text
proc guiSlider*(bounds: Rectangle, textLeft: cstring, textRight: cstring, value: var float32, minValue: float32, maxValue: float32): int32 {.importc: "GuiSlider".}
  ## Slider control, returns selected value
proc guiSliderBar*(bounds: Rectangle, textLeft: cstring, textRight: cstring, value: var float32, minValue: float32, maxValue: float32): int32 {.importc: "GuiSliderBar".}
  ## Slider Bar control, returns selected value
proc guiProgressBar*(bounds: Rectangle, textLeft: cstring, textRight: cstring, value: var float32, minValue: float32, maxValue: float32): int32 {.importc: "GuiProgressBar".}
  ## Progress Bar control, shows current progress value
proc guiStatusBar*(bounds: Rectangle, text: cstring): int32 {.importc: "GuiStatusBar".}
  ## Status Bar control, shows info text
proc guiDummyRec*(bounds: Rectangle, text: cstring): int32 {.importc: "GuiDummyRec".}
  ## Dummy control for placeholders
proc guiGrid*(bounds: Rectangle, text: cstring, spacing: float32, subdivs: int32, mouseCell: var Vector2): int32 {.importc: "GuiGrid".}
  ## Grid control, returns mouse cell position
proc guiListView*(bounds: Rectangle, text: cstring, scrollIndex: var int32, active: var int32): int32 {.importc: "GuiListView".}
  ## List View control, returns selected list item index
proc guiListView*(bounds: Rectangle, text: cstringArray, count: int32, scrollIndex: var int32, active: var int32, focus: var int32): int32 {.importc: "GuiListViewEx".}
  ## List View with extended parameters
proc guiMessageBox*(bounds: Rectangle, title: cstring, message: cstring, buttons: cstring): int32 {.importc: "GuiMessageBox".}
  ## Message Box control, displays a message
proc guiTextInputBox*(bounds: Rectangle, title: cstring, message: cstring, buttons: cstring, text: cstring, textMaxSize: int32, secretViewActive: var bool): int32 {.importc: "GuiTextInputBox".}
  ## Text Input Box control, ask for text, supports secret
proc guiColorPicker*(bounds: Rectangle, text: cstring, color: var Color): int32 {.importc: "GuiColorPicker".}
  ## Color Picker control (multiple color controls)
proc guiColorPanel*(bounds: Rectangle, text: cstring, color: var Color): int32 {.importc: "GuiColorPanel".}
  ## Color Panel control
proc guiColorBarAlpha*(bounds: Rectangle, text: cstring, alpha: var float32): int32 {.importc: "GuiColorBarAlpha".}
  ## Color Bar Alpha control
proc guiColorBarHue*(bounds: Rectangle, text: cstring, value: var float32): int32 {.importc: "GuiColorBarHue".}
  ## Color Bar Hue control
proc guiColorPickerHSV*(bounds: Rectangle, text: cstring, colorHsv: var Vector3): int32 {.importc: "GuiColorPickerHSV".}
  ## Color Picker control that avoids conversion to RGB on each call (multiple color controls)
proc guiColorPanelHSV*(bounds: Rectangle, text: cstring, colorHsv: var Vector3): int32 {.importc: "GuiColorPanelHSV".}
  ## Color Panel control that returns HSV color value, used by GuiColorPickerHSV()
