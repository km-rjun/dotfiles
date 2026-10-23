-- binds.lua — all keybindings
-- See https://wiki.hypr.land/Configuring/Basics/Binds/
-- and https://wiki.hypr.land/Configuring/Basics/Dispatchers/

local mainMod = "SUPER"

-- =========================
-- APPLICATION BINDS
-- =========================

hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd("kitty tmux new -As1"))

hl.bind(mainMod .. " + W",         hl.dsp.exec_cmd("brave --enable-features=TouchpadOverscrollHistoryNavigation --disable-experiments --password-store=gnome"))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("brave --incognito --enable-features=TouchpadOverscrollHistoryNavigation --disable-experiments"))

hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("pcmanfm"))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("wofi"))
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd('mailspring --password-store="gnome-libsecret"'))
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("slack"))

hl.bind(mainMod .. " + F",         hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + V", hl.dsp.window.float({ action = "toggle" }))
-- hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit")) -- was commented out in original, dwindle only
hl.bind(mainMod .. " + C", hl.dsp.window.close())

hl.bind("SUPER + Backspace",       hl.dsp.exec_cmd("wlogout"))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("noctalia msg session lock"))

hl.bind(mainMod .. " + V",         hl.dsp.exec_cmd("noctalia msg panel-toggle clipboard"))
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("pkill -x noctalia ; noctalia &"))

hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd("killall hyprpaper ; hyprpaper &"))

-- =========================
-- SCREENSHOTS
-- =========================

-- mkdir -p guards the target dir (not guaranteed to exist), and each shot is
-- also piped to wl-copy so it lands on the clipboard, not just on disk.
hl.bind(mainMod .. " + P",         hl.dsp.exec_cmd('mkdir -p "$HOME/Pictures/Screenshots" && f="$HOME/Pictures/Screenshots/$(date \'+%y%m%d_%H-%M-%S\').png" && grim "$f" && wl-copy < "$f"'))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd('mkdir -p "$HOME/Pictures/Screenshots" && f="$HOME/Pictures/Screenshots/$(date \'+%y%m%d_%H-%M-%S\').png" && grim -g "$(slurp)" "$f" && wl-copy < "$f"'))

-- =========================
-- WINDOW MOVEMENT (focus)
-- =========================

hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))

-- =========================
-- WINDOW MOVEMENT (move the window itself, not just focus)
-- =========================

hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.move({ direction = "down" }))

hl.bind(mainMod .. " + SHIFT + h", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + j", hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + k", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + l", hl.dsp.window.move({ direction = "right" }))

-- =========================
-- WINDOW CYCLING
-- =========================

hl.bind(mainMod .. " + Tab",         hl.dsp.window.cycle_next({ next = true }))
hl.bind(mainMod .. " + SHIFT + Tab", hl.dsp.window.cycle_next({ next = false }))

-- =========================
-- RESIZE
-- =========================
-- SUPER+Y/O/I/U resize the active window directly, no submap/mode needed.

hl.bind(mainMod .. " + Y", hl.dsp.window.resize({ x = -50, y = 0,   relative = true }), { repeating = true })
hl.bind(mainMod .. " + O", hl.dsp.window.resize({ x = 50,  y = 0,   relative = true }), { repeating = true })
hl.bind(mainMod .. " + I", hl.dsp.window.resize({ x = 0,   y = -50, relative = true }), { repeating = true })
hl.bind(mainMod .. " + U", hl.dsp.window.resize({ x = 0,   y = 50,  relative = true }), { repeating = true })

-- =========================
-- WORKSPACES
-- =========================

for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- =========================
-- WORKSPACE SCROLLING
-- =========================

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- =========================
-- MOUSE BINDS
-- =========================

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- =========================
-- MEDIA / SYSTEM KEYS
-- =========================

hl.bind("SUPER + slash",  hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("SUPER + period", hl.dsp.exec_cmd("playerctl next"))
hl.bind("SUPER + comma",  hl.dsp.exec_cmd("playerctl previous"))

-- NOTE: raw keycode "211" had no explicit code: prefix in your old conf.
-- Lua binds expect keysym names; for raw scancodes use the "code:N" form.
-- Verify against `hyprctl devices` / wiki Binds page before relying on this.
hl.bind("code:211", hl.dsp.exec_cmd("asusctl profile -n"))
hl.bind("XF86Launch3", hl.dsp.exec_cmd("alacritty"))

-- =========================
-- AUDIO
-- =========================
-- QoL: locked+repeating added to mute binds too, so they work while the
-- screen is locked and repeat if held (mirrors the volume binds).

hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),   { locked = true, repeating = true })
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"),   { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })

-- =========================
-- BRIGHTNESS
-- =========================

hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl set +3%"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 3%-"), { locked = true, repeating = true })
