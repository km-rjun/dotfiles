#!/bin/bash
status=$(bluetoothctl show | grep "Powered" | awk '{print $2}')
if [[ "$status" == "yes" ]]; then
    echo -e "power off\nquit" | bluetoothctl
else
    echo -e "power on\nquit" | bluetoothctl
fi

