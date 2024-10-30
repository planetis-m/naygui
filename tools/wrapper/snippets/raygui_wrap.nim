
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

proc listView*(bounds: Rectangle, text: TextArray, scrollIndex: var int32, active: var int32, focus: var int32): int32 =
  ## List View with extended parameters
  listViewImpl(bounds, toConstCStringArray(text.data), text.count, addr scrollIndex, addr active, addr focus)

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
  if result == 1:
    text.setLen(text.cstring.len)

proc textBox*(bounds: Rectangle, text: var string, editMode: bool): int32 =
  ## Text Box control, updates input text
  setupTextBox:
    textBoxImpl(bounds, text.cstring, text.capacity.int32 + 1, editMode)

proc textInputBox*(bounds: Rectangle, title: string, message: string, buttons: string, text: var string, secretViewActive: var bool): int32 =
  ## Text Input Box control, ask for text, supports secret.
  setupTextBox:
    textInputBoxImpl(bounds, if title.len == 0: nil else: title.cstring, if message.len == 0: nil else: message.cstring, if buttons.len == 0: nil else: buttons.cstring, text.cstring, text.capacity.int32 + 1, addr secretViewActive)

proc textInputBox*(bounds: Rectangle, title: string, message: string, buttons: string, text: var string): int32 =
  ## Text Input Box control, ask for text, without secret.
  setupTextBox:
    textInputBoxImpl(bounds, if title.len == 0: nil else: title.cstring, if message.len == 0: nil else: message.cstring, if buttons.len == 0: nil else: buttons.cstring, text.cstring, text.capacity.int32 + 1, nil)

type
  GuiStyleProperty = ControlProperty|DefaultProperty|ToggleProperty|SliderProperty|
                     ProgressBarProperty|ScrollBarProperty|CheckBoxProperty|
                     ComboBoxProperty|DropdownBoxProperty|TextBoxProperty|
                     SpinnerProperty|ListViewProperty|ColorPickerProperty

  GuiStyleValue = GuiState|GuiTextAlignment|GuiTextAlignmentVertical|
                  GuiTextWrapMode|GuiControl|int32|bool

proc guiSetStyle*[P: GuiStyleProperty, V: GuiStyleValue](
    control: GuiControl, property: P, value: V) =
  ## Set one style property
  guiSetStyleImpl(control, property.int32, value.int32)

proc guiGetStyle*[P: GuiStyleProperty](
    control: GuiControl, property: P): int32 =
  ## Get one style property
  guiGetStyleImpl(control, property.int32)
