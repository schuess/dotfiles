-- Hammerspoon config
-- Meh = Ctrl + Option + Shift

local meh = {"ctrl", "alt", "shift"}
local keyboardMapPath = hs.configdir .. "/assets/keymap.png"

local overlay = nil
local overlayVisible = false

local function deleteOverlay()
  if overlay then
    overlay:delete()
    overlay = nil
  end
  overlayVisible = false
end

local function makeOverlay()
  local screen = hs.mouse.getCurrentScreen()
  local frame = screen:fullFrame()
  local image = hs.image.imageFromPath(keyboardMapPath)

  if not image then
    hs.alert.show("Could not load keymap image")
    return nil
  end

  local c = hs.canvas.new(frame)
  c:level(hs.canvas.windowLevels.overlay)
  c:behavior({
    hs.canvas.windowBehaviors.canJoinAllSpaces,
    hs.canvas.windowBehaviors.fullScreenAuxiliary
  })
  c:alpha(1.0)

  c[1] = {
    type = "image",
    image = image,
    frame = {x = 0, y = 0, w = frame.w, h = frame.h},
    imageScaling = "scaleProportionally",
  }

  return c
end

local function showOverlay()
  deleteOverlay()
  overlay = makeOverlay()

  if overlay then
    overlay:show()
    overlayVisible = true
  end
end

local function toggleOverlay()
  if overlayVisible then
    deleteOverlay()
  else
    showOverlay()
  end
end

-- Toggle keyboard map overlay
hs.hotkey.bind(meh, "K", toggleOverlay)

-- Move mouse to center of another screen and click
hs.hotkey.bind(meh, "O", function()
  local currentScreen = hs.mouse.getCurrentScreen()
  local allScreens = hs.screen.allScreens()

  if #allScreens < 2 then
    hs.alert.show("Only one screen detected")
    return
  end

  for _, screen in ipairs(allScreens) do
    if screen:id() ~= currentScreen:id() then
      local frame = screen:frame()
      local center = hs.geometry.point(
        frame.x + frame.w / 2,
        frame.y + frame.h / 2
      )

      hs.mouse.absolutePosition(center)
      hs.eventtap.leftClick(center)
      return
    end
  end
end)


-- Cursor-jump grid driven by F-keys sent from a ZSA layer.
-- Bottom row uses Alt+F-key to dodge Mac brightness on F14/F15.
--
--   u → F13      i → F16      o → F17        (top:    upper-left, upper-mid, upper-right)
--   j → F18      k → F19      l → F20        (middle: mid-left,   center,    mid-right)
--   m → ⌥F13     , → ⌥F16     . → ⌥F17       (bottom: lower-left, lower-mid, lower-right)

local function jumpTo(col, row)
  local screen = hs.mouse.getCurrentScreen() or hs.screen.mainScreen()
  local f = screen:frame()
  hs.mouse.absolutePosition(hs.geometry.point(
    f.x + f.w * (col + 0.5) / 3,
    f.y + f.h * (row + 0.5) / 3
  ))
end

hs.hotkey.bind({},      "f13", function() jumpTo(0, 0) end)
hs.hotkey.bind({},      "f16", function() jumpTo(1, 0) end)
hs.hotkey.bind({},      "f17", function() jumpTo(2, 0) end)
hs.hotkey.bind({},      "f18", function() jumpTo(0, 1) end)
hs.hotkey.bind({},      "f19", function() jumpTo(1, 1) end)
hs.hotkey.bind({},      "f20", function() jumpTo(2, 1) end)
hs.hotkey.bind({"alt"}, "f13", function() jumpTo(0, 2) end)
hs.hotkey.bind({"alt"}, "f16", function() jumpTo(1, 2) end)
hs.hotkey.bind({"alt"}, "f17", function() jumpTo(2, 2) end)


hs.alert.show("Hammerspoon config loaded")

hs.hotkey.bind(meh, "A", function()
  hs.execute([[open "x-apple.systempreferences:com.apple.preference.universalaccess?Seeing_Display"]])
end)


