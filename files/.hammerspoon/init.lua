-- Hammerspoon config
-- Meh = Ctrl + Option + Shift
-- Hyper = Ctrl + Option + Shift + Cmd

local meh = {"ctrl", "alt", "shift"}
local hyper = {"ctrl", "alt", "shift", "cmd"}
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
hs.hotkey.bind(hyper, "O", function()
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

hs.alert.show("Hammerspoon config loaded")

hs.hotkey.bind(meh, "A", function()
  hs.execute([[open "x-apple.systempreferences:com.apple.preference.universalaccess?Seeing_Display"]])
end)
