
template setupTextBox(call: untyped): untyped =
  # Helper template to set up a text box with common code.
  if text.len == 0:
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
    textInputBoxImpl(bounds, title.cstring, message.cstring, buttons.cstring, text.cstring, text.capacity.int32 + 1, addr secretViewActive)

proc textInputBox*(bounds: Rectangle, title: string, message: string, buttons: string, text: var string): int32 =
  ## Text Input Box control, ask for text, without secret.
  setupTextBox:
    textInputBoxImpl(bounds, title.cstring, message.cstring, buttons.cstring, text.cstring, text.capacity.int32 + 1, nil)

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
