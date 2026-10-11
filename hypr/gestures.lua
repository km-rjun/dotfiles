-- gestures.lua — touchpad swipe/gesture behavior
-- See https://wiki.hypr.land/Configuring/Variables/ and .../Basics/Gestures/

hl.config({
    gestures = {
        workspace_swipe_distance           = 500,
        workspace_swipe_forever            = true,
        workspace_swipe_direction_lock     = true,
        workspace_swipe_min_speed_to_force = 20,
        workspace_swipe_invert             = true,
    },
})

hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
hl.gesture({ fingers = 4, direction = "down",       action = "fullscreen" })
hl.gesture({ fingers = 4, direction = "up",         action = "float" })
