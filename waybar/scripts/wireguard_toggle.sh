#!/bin/bash

INTERFACE="wg0"
ICON="$HOME/.config/mako/icons/wireguard.png"

if ip link show "$INTERFACE" &>/dev/null; then
    sudo wg-quick down "$INTERFACE" && \
    notify-send -i "$ICON" "WireGuard VPN" "Disconnected"
else
    sudo wg-quick up "$INTERFACE" && \
    notify-send -i "$ICON" "WireGuard VPN" "Connected"
fi

