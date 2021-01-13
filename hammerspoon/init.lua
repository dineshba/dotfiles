hs.hotkey.bind({"alt", "ctrl", "cmd", "shift"}, "r", function()
    hs.reload()
end)

hs.hotkey.bind({"alt", "ctrl", "cmd", "shift"}, "space", function()
  hs.application.launchOrFocus("/Applications/Alacritty.app")
end)

hs.hotkey.bind({"alt", "ctrl", "cmd", "shift"}, "z", function()
  hs.application.launchOrFocus("/Applications/Zoom.us.app")
end)

hs.hotkey.bind({"alt", "ctrl", "cmd", "shift"}, "c", function()
  hs.application.launchOrFocus("/Applications/Visual Studio Code.app")
end)

hs.hotkey.bind({"alt", "ctrl", "cmd", "shift"}, "s", function()
  hs.application.launchOrFocus("/Applications/Slack.app")
end)

hs.hotkey.bind({"alt", "ctrl", "cmd", "shift"}, "b", function()
  hs.application.launchOrFocus("Firefox")
end)

hs.hotkey.bind({"alt", "ctrl", "cmd", "shift"}, "b", function()
  hs.application.launchOrFocus("Firefox")
end)
