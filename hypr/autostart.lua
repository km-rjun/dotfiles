-- autostart.lua
-- See https://wiki.hypr.land/Configuring/Basics/Autostart/
-- exec_cmd spawns off the event loop, safe to call from hl.on callbacks.

hl.on("hyprland.start", function()
    hl.dispatch(hl.dsp.exec_cmd("noctalia"))
    hl.dispatch(hl.dsp.exec_cmd("sleep 60 && slack -su"))
    hl.dispatch(hl.dsp.exec_cmd("~/.config/hypr/xdg-portal-hyprland"))
    hl.dispatch(hl.dsp.exec_cmd("mpd"))
    hl.dispatch(hl.dsp.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"))
    hl.dispatch(hl.dsp.exec_cmd("sh -c 'eval $(gnome-keyring-daemon --start --components=secrets) && dbus-update-activation-environment --all'"))
end)
