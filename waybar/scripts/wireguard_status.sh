#!/bin/bash

INTERFACE="wg0"
ICON_CONNECTED="●"  # Solid circle (connected)
ICON_DISCONNECTED="◯"  # Open circle (disconnected)

if ip link show "$INTERFACE" &>/dev/null; then
    echo "{\"text\": \"$ICON_CONNECTED\", \"class\": \"connected\", \"tooltip\": \"WireGuard VPN Active\"}"
else
    echo "{\"text\": \"$ICON_DISCONNECTED\", \"class\": \"disconnected\", \"tooltip\": \"WireGuard VPN Inactive\"}"
fi

