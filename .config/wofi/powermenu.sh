#!/bin/bash

entries="\tLogout\n\tSuspend\n⭮\tReboot\n⏻\tPoweroff"

selected=$(echo -e $entries|wofi --width 450 --height 220 --dmenu --cache-file /dev/null | awk '{print tolower($2)}')
case $selected in
  logout)
    exec hyprctl dispatch exit 0;;
  suspend)
    exec systemctl suspend;;
  reboot)
    exec reboot;;
  shutdown)
    exec poweroff;;
esac
