-- misc.lua — bind behavior flags, misc, ecosystem
-- See https://wiki.hypr.land/Configuring/Variables/

hl.config({
    binds = {
        workspace_back_and_forth = true,
        allow_workspace_cycles   = true,
        pass_mouse_when_bound    = false,
    },

    misc = {
        disable_hyprland_logo    = true,
        disable_splash_rendering = true,
        mouse_move_enables_dpms  = true,
        vrr                      = 0,
        enable_swallow           = true,
    },

    ecosystem = {
        no_update_news = true,
    },
})
