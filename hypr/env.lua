-- env.lua — environment variables, xwayland, cursor
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

hl.env("XCURSOR_SIZE", "20")
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("NVD_BACKEND", "direct")

hl.config({
    xwayland = {
        force_zero_scaling = true,
    },
    cursor = {
        no_hardware_cursors = false,
    },
})
