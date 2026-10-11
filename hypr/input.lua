-- input.lua — keyboard, mouse, touchpad
-- See https://wiki.hypr.land/Configuring/Variables/

hl.config({
    input = {
        kb_layout  = "us",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",

        accel_profile = "flat",
        follow_mouse  = 1,
        sensitivity   = 0.3,

        touchpad = {
            natural_scroll       = true,
            scroll_factor        = 0.2,
            disable_while_typing = true,
        },
    },
})
