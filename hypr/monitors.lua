-- monitors.lua
-- See https://wiki.hypr.land/Configuring/Basics/Monitors/

hl.monitor({
    output   = "desc:Chimei Innolux Corporation 0x1521",
    mode     = "1920x1080@144",
    position = "0x0",
    scale    = 1.2,
})

hl.monitor({
    output   = "HDMI-A-1",
    mode     = "1920x1080@60",
    position = "auto",
    scale    = 1,
})
