-- look.lua — general, decoration, animations, dwindle layout

hl.config({
    general = {
        gaps_in     = 2,
        gaps_out    = 6,
        border_size = 1,

        -- Border colors are owned by noctalia.lua (applied after this file
        -- loads, via Noctalia's generated theme) — don't set general.col here,
        -- it would just get overwritten.
        layout = "dwindle",
    },

    decoration = {
        rounding           = 8,
        inactive_opacity   = 0.85,
        fullscreen_opacity = 1.0,

        blur = {
            enabled           = true,
            size              = 6,
            passes            = 3,
            new_optimizations = true,
        },
    },

    dwindle = {
        preserve_split = true,
        -- pseudotile = false, -- was commented out in the original config
    },
})

-- Animation curves & leaves — https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/

hl.curve("myBezier", { type = "bezier", points = { {0.10, 0.9}, {0.1, 1.05} } })

hl.config({ animations = { enabled = true } })

hl.animation({ leaf = "windows",    enabled = true, speed = 7,  bezier = "myBezier", style = "slide" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 7,  bezier = "myBezier", style = "slide" })
hl.animation({ leaf = "border",     enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "fade",       enabled = true, speed = 7,  bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 6,  bezier = "default" })
