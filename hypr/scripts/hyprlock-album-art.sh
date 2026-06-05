#!/usr/bin/env bash
# hyprlock-album-art.sh
# Extracts current playerctl album art to /tmp/hyprlock_album_art.png
# Run this before/alongside hyprlock

FALLBACK="/home/rjun/.config/face"
OUTPUT="/tmp/hyprlock_album_art.png"

get_art() {
    local url
    url=$(playerctl metadata mpris:artUrl 2>/dev/null)

    if [[ -z "$url" ]]; then
        cp "$FALLBACK" "$OUTPUT"
        return
    fi

    # Handle file:// URIs
    if [[ "$url" == file://* ]]; then
        local path="${url#file://}"
        # URL-decode
        path=$(python3 -c "import urllib.parse, sys; print(urllib.parse.unquote(sys.argv[1]))" "$path")
        if [[ -f "$path" ]]; then
            convert "$path" -resize 200x200^ -gravity center -extent 200x200 "$OUTPUT" 2>/dev/null \
                || cp "$path" "$OUTPUT"
            return
        fi
    fi

    # Handle http/https
    if [[ "$url" == http* ]]; then
        curl -sL "$url" -o /tmp/hyprlock_art_raw 2>/dev/null \
            && convert /tmp/hyprlock_art_raw -resize 200x200^ -gravity center -extent 200x200 "$OUTPUT" 2>/dev/null \
            || cp "$FALLBACK" "$OUTPUT"
        return
    fi

    cp "$FALLBACK" "$OUTPUT"
}

# Initial fetch
get_art

# Watch for track changes and update art
playerctl --follow metadata mpris:artUrl 2>/dev/null | while read -r _; do
    get_art
done
