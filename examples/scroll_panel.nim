import raylib, raygui, std/strformat

const
  screenWidth = 800
  screenHeight = 450

proc drawStyleEditControls() =
  # ScrollPanel style controls
  discard groupBox(Rectangle(x: 550, y: 170, width: 220, height: 205), "SCROLLBAR STYLE")

  # Border width control
  var style = guiGetStyle(Scrollbar, BorderWidth)
  discard label(Rectangle(x: 555, y: 195, width: 110, height: 10), "BORDER_WIDTH")
  discard spinner(Rectangle(x: 670, y: 190, width: 90, height: 20), "", style, 0, 6, false)
  guiSetStyle(Scrollbar, BorderWidth, style)

  # Arrows size control
  style = guiGetStyle(Scrollbar, ArrowsSize)
  discard label(Rectangle(x: 555, y: 220, width: 110, height: 10), "ARROWS_SIZE")
  discard spinner(Rectangle(x: 670, y: 215, width: 90, height: 20), "", style, 4, 14, false)
  guiSetStyle(Scrollbar, ArrowsSize, style)

  # Slider padding control
  style = guiGetStyle(Scrollbar, SliderPadding)
  discard label(Rectangle(x: 555, y: 245, width: 110, height: 10), "SLIDER_PADDING")
  discard spinner(Rectangle(x: 670, y: 240, width: 90, height: 20), "", style, 0, 14, false)
  guiSetStyle(Scrollbar, SliderPadding, style)

  # Arrows visible control
  var scrollBarArrows = bool(guiGetStyle(Scrollbar, ArrowsVisible))
  discard checkBox(Rectangle(x: 565, y: 280, width: 20, height: 20), "ARROWS_VISIBLE", scrollBarArrows)
  guiSetStyle(Scrollbar, ArrowsVisible, cint(scrollBarArrows))

  # Additional slider padding control
  style = guiGetStyle(Scrollbar, SliderPadding)
  discard label(Rectangle(x: 555, y: 325, width: 110, height: 10), "SLIDER_PADDING")
  discard spinner(Rectangle(x: 670, y: 320, width: 90, height: 20), "", style, 0, 14, false)
  guiSetStyle(Scrollbar, SliderPadding, style)

  # Slider width control
  style = guiGetStyle(Scrollbar, SliderWidth)
  discard label(Rectangle(x: 555, y: 350, width: 110, height: 10), "SLIDER_WIDTH")
  discard spinner(Rectangle(x: 670, y: 345, width: 90, height: 20), "", style, 2, 100, false)
  guiSetStyle(Scrollbar, SliderWidth, style)

  # Scrollbar side toggle
  let text = if guiGetStyle(ListView, ScrollbarSide) == ScrollbarLeftSide:
    "SCROLLBAR: LEFT"
  else:
    "SCROLLBAR: RIGHT"
  var toggleScrollBarSide = bool(guiGetStyle(ListView, ScrollbarSide))
  discard toggle(Rectangle(x: 560, y: 110, width: 200, height: 35), text, toggleScrollBarSide)
  guiSetStyle(ListView, ScrollbarSide, toggleScrollBarSide)

  # ScrollBar style controls section
  discard groupBox(Rectangle(x: 550, y: 20, width: 220, height: 135), "SCROLLPANEL STYLE")

  style = guiGetStyle(ListView, ScrollbarWidth)
  discard label(Rectangle(x: 555, y: 35, width: 110, height: 10), "SCROLLBAR_WIDTH")
  discard spinner(Rectangle(x: 670, y: 30, width: 90, height: 20), "", style, 6, 30, false)
  guiSetStyle(ListView, ScrollbarWidth, style)

  style = guiGetStyle(Default, BorderWidth)
  discard label(Rectangle(x: 555, y: 60, width: 110, height: 10), "BORDER_WIDTH")
  discard spinner(Rectangle(x: 670, y: 55, width: 90, height: 20), "", style, 0, 20, false)
  guiSetStyle(Default, BorderWidth, style)

proc main() =
  # Initialization
  initWindow(screenWidth, screenHeight, "naygui - ScrollPanel()")
  defer: closeWindow()

  var
    panelRec = Rectangle(x: 20, y: 40, width: 200, height: 150)
    panelContentRec = Rectangle(x: 0, y: 0, width: 340, height: 340)
    panelView: Rectangle
    panelScroll = Vector2(x: 99, y: -20)
    showContentArea = true

  setTargetFPS(60)

  # Main game loop
  while not windowShouldClose():
    # Draw
    drawing():
      clearBackground(RayWhite)

      # Draw scroll coordinates
      drawText(&"[{panelScroll.x:.1f}, {panelScroll.y:.1f}]", 4, 4, 20, Red)

      # Draw scroll panel
      discard scrollPanel(panelRec, "", panelContentRec, panelScroll, panelView)

      # Draw grid inside scroll panel with scissor mode
      beginScissorMode(int32(panelView.x), int32(panelView.y),
                       int32(panelView.width), int32(panelView.height))

      var tmp: Vector2
      discard grid(Rectangle(
        x: panelRec.x + panelScroll.x,
        y: panelRec.y + panelScroll.y,
        width: panelContentRec.width,
        height: panelContentRec.height
      ), "", 16, 3, tmp)

      endScissorMode()

      # Draw content area if enabled
      if showContentArea:
        drawRectangle(int32(panelRec.x + panelScroll.x),
                     int32(panelRec.y + panelScroll.y),
                     int32(panelContentRec.width),
                     int32(panelContentRec.height),
                     fade(Red, 0.1))

      drawStyleEditControls()

      # Draw controls
      discard checkBox(Rectangle(x: 565, y: 80, width: 20, height: 20),
                      "SHOW CONTENT AREA",
                      showContentArea)

      discard sliderBar(Rectangle(x: 590, y: 385, width: 145, height: 15),
                       "WIDTH",
                       $int32(panelContentRec.width),
                       panelContentRec.width,
                       1, 600)

      discard sliderBar(Rectangle(x: 590, y: 410, width: 145, height: 15),
                       "HEIGHT",
                       $int32(panelContentRec.height),
                       panelContentRec.height,
                       1, 400)

when isMainModule:
  main()
