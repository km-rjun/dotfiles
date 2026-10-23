-- autostart.lua
-- See https://wiki.hypr.land/Configuring/Basics/Autostart/
-- exec_cmd spawns off the event loop, safe to call from hl.on callbacks.

hl.on("hyprland.start", function()
    -- Env/portal/keyring go FIRST: anything launched below (noctalia, the
    -- XDG portal, etc.) should see a session that's already registered with
    -- D-Bus/systemd, or portal-dependent features (screen share, file
    -- pickers) can misbehave on first login.
    hl.dispatch(hl.dsp.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"))
    hl.dispatch(hl.dsp.exec_cmd("sh -c 'eval $(gnome-keyring-daemon --start --components=secrets) && dbus-update-activation-environment --all'"))
    hl.dispatch(hl.dsp.exec_cmd("~/.config/hypr/xdg-portal-hyprland"))

    hl.dispatch(hl.dsp.exec_cmd("noctalia"))
    hl.dispatch(hl.dsp.exec_cmd("hypridle"))
    hl.dispatch(hl.dsp.exec_cmd("mpd"))
end)
