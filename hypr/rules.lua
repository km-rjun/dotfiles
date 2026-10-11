-- rules.lua — window rules, layer rules, dynamic workspace assignment
-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Layer-Rules/

-- QoL: workspace-per-app is handled dynamically below via hl.on("window.open")
-- instead of six separate static hl.window_rule() class-regex entries.
-- This is more robust for apps that share a class across multiple windows,
-- and makes it trivial to extend (edit one table instead of adding rules).

local appWorkspaces = {
    ["kitty"]                        = 1,
    ["brave-browser"]                = 2,
    ["slack"]                        = 3,
    ["Mailspring"]                   = 4,
    ["org.keepassxc.KeePassXC"]      = 5,
}

hl.on("window.open", function(win)
    if win == nil then return end

    local ws = appWorkspaces[win.class]
    if ws ~= nil then
        hl.dispatch(hl.dsp.window.move({ workspace = ws, window = "address:" .. win.address }))
        return
    end

    -- Spotify matched by title in the original config (^(Spotify).*)
    if win.title ~= nil and win.title:match("^Spotify") then
        hl.dispatch(hl.dsp.window.move({ workspace = 6, window = "address:" .. win.address }))
    end
end)

-- Static rules for things that aren't workspace assignment stay as window_rule.

hl.window_rule({
    name         = "pixelens-action-bar",
    match        = { class = "pixelens-action-bar" },
    float        = true,
    center       = true,
    stay_focused = true,
    size         = "620 90",
})

-- =========================
-- LAYER RULES
-- =========================

hl.layer_rule({
    name         = "logout-dialog",
    match        = { namespace = "logout_dialog" },
    blur         = true,
    ignore_alpha = 0.5,
})
