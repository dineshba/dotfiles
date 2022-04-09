local hyperKey = {'ctrl', 'alt', 'cmd', 'shift'}

hs.hotkey.bind(hyperKey, "r", function()
    hs.reload()
end)

hs.hotkey.bind(hyperKey, "space", function()
  hs.application.launchOrFocus("/Applications/Alacritty.app")
end)

hs.hotkey.bind(hyperKey, "z", function()
  hs.application.launchOrFocus("/Applications/Zoom.us.app")
end)

hs.hotkey.bind(hyperKey, "c", function()
  hs.application.launchOrFocus("/Applications/Visual Studio Code.app")
end)

hs.hotkey.bind(hyperKey, "s", function()
  hs.application.launchOrFocus("/Applications/Slack.app")
end)

hs.hotkey.bind(hyperKey, "b", function()
  hs.execute [["export" "MOZ_DISABLE_SAFE_MODE_KEY" "1"]]
  hs.application.launchOrFocus("Firefox")
end)

hs.hotkey.bind(hyperKey, "g", function()
  hs.application.launchOrFocus("Citrix SSO")
end)

hs.hotkey.bind(hyperKey, "t", function()
  hs.application.launchOrFocus("Microsoft Teams")
end)

hs.hotkey.bind(hyperKey, "a", function()
  hs.application.launchOrFocus("FaceTime.app")
end)

hs.hotkey.bind(hyperKey, "s", function()
  hs.caffeinate.systemSleep()
end)

hs.hotkey.bind(hyperKey, "e", function()
  hs.application.launchOrFocus("Ferdi.app")
end)

hs.hotkey.bind(hyperKey, "c", function()
  hs.application.launchOrFocus("Visual Studio Code.app")
end)
