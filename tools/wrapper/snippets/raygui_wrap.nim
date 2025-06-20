
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
                      ValueBoxProperty|ListViewProperty|ColorPickerProperty

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
  elif property is ValueBoxProperty:
    assert control in {Control11, Spinner}, "ValueBoxProperty should match ValueBox control"
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
