local hyperKey = {'ctrl', 'alt', 'cmd', 'shift'}

hs.hotkey.bind(hyperKey, "r", function()
    hs.reload()
end)

hs.hotkey.bind(hyperKey, "space", function()
  local app = hs.application.get("alacritty")
    if app then
        if not app:mainWindow() then
            app:selectMenuItem({"Alacritty", "New OS window"})
        elseif app:isFrontmost() then
            app:hide()
        else
            app:activate()
        end
    else
        hs.application.launchOrFocus("/Applications/Alacritty.app")
    end
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
  hs.application.launchOrFocus("Firefox")
end)

hs.hotkey.bind(hyperKey, "g", function()
  hs.application.launchOrFocus("Citrix SSO")
end)

hs.hotkey.bind(hyperKey, "t", function()
  hs.application.launchOrFocus("Microsoft Teams")
end)

hs.hotkey.bind(hyperKey, "f", function()
  hs.application.launchOrFocus("FaceTime.app")
end)