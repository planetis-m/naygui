# ****************************************************************************************
#
#   raygui - controls test suite
#
#   TEST CONTROLS:
#       - guiDropdownBox()
#       - guiCheckBox()
#       - guiSpinner()
#       - guiValueBox()
#       - guiTextBox()
#       - guiButton()
#       - guiComboBox()
#       - guiListView()
#       - guiToggleGroup()
#       - guiColorPicker()
#       - guiSlider()
#       - guiSliderBar()
#       - guiProgressBar()
#       - guiColorBarAlpha()
#       - guiScrollPanel()
#
#
#   DEPENDENCIES:
#       raylib 4.5          - Windowing/input management and drawing
#       raygui 3.5          - Immediate-mode GUI controls with custom styling and icons
#
#   COMPILATION (Windows - MinGW):
#       gcc -o $(NAME_PART).exe $(FILE_NAME) -I../../src -lraylib -lopengl32 -lgdi32 -std=c99
#
#   LICENSE: zlib/libpng
#
#   Copyright (c) 2016-2023 Ramon Santamaria (@raysan5)
#
# ****************************************************************************************

# {.passC: "-DRAYGUI_CUSTOM_ICONS".} # It requires providing gui_icons.h in the same directory
# include gui_icons # External icons data provided, it can be generated with rGuiIcons tool

import raylib, raygui, std/[strutils, strformat]

# raygui embedded styles

# import
#   ../styles/style_cyber, ../styles/style_jungle, ../styles/style_lavanda,
#   ../styles/style_dark, ../styles/style_bluish, ../styles/style_terminal

const
  screenWidth = 800
  screenHeight = 450

# ----------------------------------------------------------------------------------------
# Program main entry point
# ----------------------------------------------------------------------------------------

converter Control2int32*(x: GuiControl): int32 = x.int32
converter DefaultProperty2int32*(x: GuiDefaultProperty): int32 = x.int32
converter ControlProperty2int32*(x: GuiControlProperty): int32 = x.int32
converter TextAlignment2int32*(x: GuiTextAlignment): int32 = x.int32
converter IconName2int32*(x: GuiIconName): int32 = x.int32
converter State2int32*(x: GuiState): int32 = x.int32

proc main =
  # Initialization
  # --------------------------------------------------------------------------------------
  initWindow(screenWidth, screenHeight, "raygui - controls test suite")
  setExitKey(Null)
  # GUI controls initialization
  # --------------------------------------------------------------------------------------
  var dropdownBox000Active: int32 = 0
  var dropDown000EditMode: bool = false
  var dropdownBox001Active: int32 = 0
  var dropDown001EditMode: bool = false
  var spinner001Value: int32 = 0
  var spinnerEditMode: bool = false
  var valueBox002Value: int32 = 0
  var valueBoxEditMode: bool = false
  let textBoxText = "Text box"
  var textBoxEditMode: bool = false
  var listViewScrollIndex: int32 = 0
  var listViewActive: int32 = -1
  var listViewExScrollIndex: int32 = 0
  var listViewExActive: int32 = 2
  var listViewExFocus: int32 = -1
  let listViewExList: array[8, cstring] = [
      "This", "is", "a", "list view",
      "with", "disable", "elements", "amazing!"]
  let multiTextBoxText = "Multi text box"
  var multiTextBoxEditMode: bool = false
  var colorPickerValue: Color = Red
  var sliderValue: float32 = 50.0
  var sliderBarValue: float32 = 60
  var progressValue: float32 = 0.4
  var forceSquaredChecked: bool = false
  var alphaValue: float32 = 0.5
  # var comboBoxActive: int32 = 1
  var visualStyleActive: int32 = 0
  var prevVisualStyleActive: int32 = 0
  var toggleGroupActive: int32 = 0
  var viewScroll = Vector2(x: 0, y: 0)
  # --------------------------------------------------------------------------------------
  # Custom GUI font loading
  # let font = loadFont("fonts/rainyhearts16.ttf", 12, 0, 0)
  # guiSetFont(font)
  var exitWindow: bool = false
  var showMessageBox: bool = false
  var textInput: array[256, char]
  var showTextInputBox: bool = false
  var textInputFileName: array[256, char]
  setTargetFPS(60)
  # --------------------------------------------------------------------------------------
  # Main game loop
  while not exitWindow:     # Detect window close button or ESC key
    # Update
    # ------------------------------------------------------------------------------------
    exitWindow = windowShouldClose()
    if isKeyPressed(Escape):
      showMessageBox = not showMessageBox
    if isKeyDown(LeftControl) and isKeyPressed(S):
      showTextInputBox = true
    if isFileDropped():
      var droppedFiles = getDroppedFiles()
      if droppedFiles.len > 0 and
          endsWith(droppedFiles[0], ".rgs"):
        guiLoadStyle(droppedFiles[0])
      # Clear internal buffers
    progressValue += 0.002
    # if progressValue >= 1: progressValue = 0
    if isKeyPressed(Space):
      progressValue = 0.2
    # if visualStyleActive != prevVisualStyleActive:
    #   guiLoadStyleDefault()
    #   case visualStyleActive
    #   of 0:
    #     discard
    #   of 1:
    #     guiLoadStyleJungle()
    #   of 2:
    #     guiLoadStyleLavanda()
    #   of 3:
    #     guiLoadStyleDark()
    #   of 4:
    #     guiLoadStyleBluish()
    #   of 5:
    #     guiLoadStyleCyber()
    #   of 6:
    #     guiLoadStyleTerminal()
    #   else:
    #     discard
    #   guiSetStyle(Label, TextAlignment, Left)
    #   prevVisualStyleActive = visualStyleActive
    beginDrawing()
    clearBackground(getColor(guiGetStyle(Default.int32, BackgroundColor).uint32))
    # raygui: controls drawing
    # ----------------------------------------------------------------------------------
    # Check all possible events that require GuiLock
    if dropDown000EditMode or dropDown001EditMode:
      guiLock()
    discard guiCheckBox(Rectangle(x: 25, y: 108, width: 15, height: 15), "FORCE CHECK!", forceSquaredChecked)
    guiSetStyle(TextBox, TextAlignment, Center)
    # guiSetStyle(ValueBox, TextAlignment, Left)
    if guiSpinner(Rectangle(x: 25, y: 135, width: 125, height: 30), nil, spinner001Value, 0, 100, spinnerEditMode) != 0:
      spinnerEditMode = not spinnerEditMode
    if guiValueBox(Rectangle(x: 25, y: 175, width: 125, height: 30), nil, valueBox002Value, 0, 100, valueBoxEditMode) != 0:
      valueBoxEditMode = not valueBoxEditMode
    guiSetStyle(TextBox, TextAlignment, Left.int32)
    if guiTextBox(Rectangle(x: 25, y: 215, width: 125, height: 30), textBoxText, 64, textBoxEditMode) != 0:
      textBoxEditMode = not textBoxEditMode
    guiSetStyle(Button, TextAlignment, Center)
    if guiButton(Rectangle(x: 25, y: 255, width: 125, height: 30), guiIconText(FileSave, "Save File")) != 0:
      showTextInputBox = true
    discard guiGroupBox(Rectangle(x: 25, y: 310, width: 125, height: 150), "STATES")
    # guiLock()
    guiSetState(Normal.int32)
    if guiButton(Rectangle(x: 30, y: 320, width: 115, height: 30), "NORMAL") != 0:
      discard
    guiSetState(Focused)
    if guiButton(Rectangle(x: 30, y: 355, width: 115, height: 30), "FOCUSED") != 0:
      discard
    guiSetState(Pressed)
    if guiButton(Rectangle(x: 30, y: 390, width: 115, height: 30), "#15#PRESSED") != 0:
      discard
    guiSetState(Disabled)
    if guiButton(Rectangle(x: 30, y: 425, width: 115, height: 30), "DISABLED") != 0:
      discard
    guiSetState(Normal.int32)
    # guiUnlock()
    discard guiComboBox(Rectangle(x: 25, y: 470, width: 125, height: 30),
        "default;Jungle;Lavanda;Dark;Bluish;Cyber;Terminal", visualStyleActive)
    # NOTE: GuiDropdownBox must draw after any other control that can be covered on unfolding
    guiUnlock()
    guiSetStyle(Dropdownbox, TextAlignment, Left.int32)
    if guiDropdownBox(Rectangle(x: 25, y: 65, width: 125, height: 30),
        "#01#ONE;#02#TWO;#03#THREE;#04#FOUR", dropdownBox001Active, dropDown001EditMode) != 0:
      dropDown001EditMode = not dropDown001EditMode
    guiSetStyle(Dropdownbox, TextAlignment, Center)
    if guiDropdownBox(Rectangle(x: 25, y: 25, width: 125, height: 30), "ONE;TWO;THREE",
        dropdownBox000Active, dropDown000EditMode) != 0:
      dropDown000EditMode = not dropDown000EditMode
    discard guiListView(Rectangle(x: 165, y: 25, width: 140, height: 140),
        "Charmander;Bulbasaur;#18#Squirtel;Pikachu;Eevee;Pidgey",
        listViewScrollIndex, listViewActive)
    discard guiListView(Rectangle(x: 165, y: 180, width: 140, height: 200), cast[cstringArray](addr listViewExList),
        8, listViewExScrollIndex, listViewExActive, listViewExFocus)
    # guiToggle(Rectangle(x: 165, y: 400, width: 140, height: 25), "#1#ONE", toggleGroupActive)
    discard guiToggleGroup(Rectangle(x: 165, y: 400, width: 140, height: 25),
        "#1#ONE\n#3#TWO\n#8#THREE\n#23#", toggleGroupActive)
    # Third GUI column
    discard guiPanel(Rectangle(x: 320, y: 25, width: 225, height: 140), "Panel Info")
    discard guiColorPicker(Rectangle(x: 320, y: 185, width: 196, height: 192), nil, colorPickerValue)
    # guiDisable()
    discard guiSlider(Rectangle(x: 355, y: 400, width: 165, height: 20), "TEST",
        &"%{sliderValue:2.2f}", sliderValue, -50, 100)
    discard guiSliderBar(Rectangle(x: 320, y: 430, width: 200, height: 20), nil,
        &"%{int32(sliderBarValue)}", sliderBarValue, 0, 100)
    discard guiProgressBar(Rectangle(x: 320, y: 460, width: 200, height: 20), nil,
        &" %{int(progressValue * 100)}%%", progressValue, 0, 1)
    guiEnable()
    # NOTE: View rectangle could be used to perform some scissor test
    var view: Rectangle
    discard guiScrollPanel(Rectangle(x: 560, y: 25, width: 102, height: 354), nil,
        Rectangle(x: 560, y: 25, width: 300, height: 1200), viewScroll, view)
    var mouseCell = Vector2(x: 0, y: 0)
    discard guiGrid(Rectangle(x: 560, y: 25 + 180 + 195, width: 100, height: 120), nil, 20, 2, mouseCell)
    discard guiStatusBar(Rectangle(x: 0, y: float32(getScreenHeight()) - 20,
        width: float32(getScreenWidth()), height: 20), "This is a status bar")
    discard guiColorBarAlpha(Rectangle(x: 320, y: 490, width: 200, height: 30), nil, alphaValue)
    if showMessageBox:
      drawRectangle(0, 0, getScreenWidth(), getScreenHeight(), fade(RayWhite, 0.8))
      let result = guiMessageBox(Rectangle(
          x: float32(getScreenWidth() div 2) - 125,
          y: float32(getScreenHeight() div 2) - 50, width: 250, height: 100),
          guiIconText(Exit, "Close Window"), "Do you really want to exit?", "Yes;No")
      if result == 0 or result == 2:
        showMessageBox = false
      elif result == 1:
        exitWindow = true
    if showTextInputBox:
      drawRectangle(0, 0, getScreenWidth(), getScreenHeight(), fade(RayWhite, 0.8))
      var tmp = false
      let result = guiTextInputBox(Rectangle(
          x: float32(getScreenWidth() div 2) - 120,
          y: float32(getScreenHeight() div 2) - 60, width: 240, height: 140), "Save",
          guiIconText(FileSave, "Save file as..."), "Ok;Cancel",
          cast[cstring](addr textInput), 255, tmp)
      if result == 1:
        # TODO: Validate textInput value and save
        textInputFileName = textInput
      if result == 0 or result == 1 or result == 2:
        showTextInputBox = false
        textInput.reset()
        textInput[0] = '\x00'
    endDrawing()
    # ----------------------------------------------------------------------------------
  # De-Initialization
  # --------------------------------------------------------------------------------------
  closeWindow()
  # Close window and OpenGL context
  # --------------------------------------------------------------------------------------

main()
