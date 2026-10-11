-- hyprland.lua — entry point (Hyprland 0.55+ Lua config)
-- Place this whole folder's contents at ~/.config/hypr/
-- Ref: https://wiki.hypr.land/Configuring/Start/

require("monitors")
require("env")
require("autostart")
require("input")
require("look")
require("gestures")
require("misc")
require("rules")
require("binds")

-- For Noctalia Color templates
require("noctalia").apply_theme()
