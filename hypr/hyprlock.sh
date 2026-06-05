#!/usr/bin/env bash
# ~/.config/hypr/hyprlock.sh
# Usage:
#   hyprlock.sh launch          — fetch art, start hyprlock, watch for track changes
#   hyprlock.sh title           — print current track title (truncated)
#   hyprlock.sh artist          — print current artist
#   hyprlock.sh playpause       — print play/pause icon
#   hyprlock.sh prev            — print prev icon
#   hyprlock.sh next            — print next icon
#   hyprlock.sh battery         — print battery icon + percent

# ── DBus (hyprlock runs in minimal env) ──────────────────────────────────────
if [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
    export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u)/bus"
fi

ART_PATH="/tmp/hyprlock_album_art.png"
ART_URL_CACHE="/tmp/hyprlock_art_url"

# ── Helpers ───────────────────────────────────────────────────────────────────
media_active() {
    local s
    s=$(playerctl status 2>/dev/null)
    [ "$s" = "Playing" ] || [ "$s" = "Paused" ]
}

fetch_art() {
    local url
    url=$(playerctl metadata mpris:artUrl 2>/dev/null)
    [[ -z "$url" ]] && return 1

    # Local file URI
    if [[ "$url" == file://* ]]; then
        local p="${url#file://}"
        [[ -f "$p" ]] && cp "$p" "$ART_PATH" && return 0
        return 1
    fi

    # Skip re-download if same URL and file exists
    local cached
    cached=$(cat "$ART_URL_CACHE" 2>/dev/null)
    if [[ "$url" == "$cached" && -f "$ART_PATH" ]]; then
        return 0
    fi

    if curl -sf --max-time 5 -o "$ART_PATH" "$url"; then
        echo "$url" > "$ART_URL_CACHE"
        return 0
    fi
    return 1
}

# ── Launch mode ───────────────────────────────────────────────────────────────
cmd_launch() {
    fetch_art

    hyprlock &
    local SHELL_PID=$!

    # hyprlock may fork — wait briefly then grab the real PID
    sleep 0.5
    local HYPRLOCK_PID
    HYPRLOCK_PID=$(pgrep -x hyprlock | head -1)
    [[ -z "$HYPRLOCK_PID" ]] && HYPRLOCK_PID=$SHELL_PID

    # React to track changes instantly — no polling
    (
        playerctl --follow metadata --format '{{mpris:artUrl}}' 2>/dev/null | \
        while IFS= read -r _line; do
            kill -0 "$HYPRLOCK_PID" 2>/dev/null || break
            fetch_art
            # Signal hyprlock to reload image widget
            kill -USR2 "$HYPRLOCK_PID" 2>/dev/null
        done
    ) &
    local FOLLOW_PID=$!

    # Wait until hyprlock exits
    wait "$SHELL_PID" 2>/dev/null
    while kill -0 "$HYPRLOCK_PID" 2>/dev/null; do sleep 0.5; done

    kill "$FOLLOW_PID" 2>/dev/null
    wait "$FOLLOW_PID" 2>/dev/null
    rm -f "$ART_URL_CACHE"
}

# ── Label modes ───────────────────────────────────────────────────────────────
case "$1" in
    launch)
        cmd_launch
        ;;

    title)
        media_active && playerctl metadata title 2>/dev/null | cut -c1-22 || echo ""
        ;;

    artist)
        media_active && playerctl metadata artist 2>/dev/null | cut -c1-22 || echo ""
        ;;

    playpause)
        s=$(playerctl status 2>/dev/null)
        if   [ "$s" = "Playing" ]; then echo ""
        elif [ "$s" = "Paused"  ]; then echo ""
        fi
        ;;

    prev)
        media_active && echo "" || echo ""
        ;;

    next)
        media_active && echo "" || echo ""
        ;;

    battery)
        BAT_PATH=""
        for p in /sys/class/power_supply/BAT0 \
                 /sys/class/power_supply/BAT1 \
                 /sys/class/power_supply/BATT \
                 /sys/class/power_supply/battery; do
            [ -f "$p/capacity" ] && BAT_PATH="$p" && break
        done
        [ -z "$BAT_PATH" ] && BAT_PATH=$(
            find /sys/class/power_supply/ -name capacity 2>/dev/null \
            | grep -iv ac | head -1 | xargs -I{} dirname {}
        )
        [ -z "$BAT_PATH" ] && echo "" && exit 0

        BAT=$(cat "$BAT_PATH/capacity")
        STATUS=$(cat "$BAT_PATH/status" 2>/dev/null)
        if   [ "$STATUS" = "Charging" ]; then ICON=""
        elif [ "$BAT" -le 10 ]; then ICON=""
        elif [ "$BAT" -le 20 ]; then ICON=""
        elif [ "$BAT" -le 40 ]; then ICON=""
        elif [ "$BAT" -le 60 ]; then ICON=""
        elif [ "$BAT" -le 80 ]; then ICON=""
        else ICON=""
        fi
        echo "$ICON ${BAT}%"
        ;;
esac
