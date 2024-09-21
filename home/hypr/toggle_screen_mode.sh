#!/usr/bin/env bash
LAPTOP_MONITOR="eDP-1"
active_monitors_count=$(hyprctl monitors | grep "Monitor" | wc -l)

if [ "$active_monitors_count" -eq 1 ]; then
    hyprctl dispatch exec "hyprctl keyword monitor \"$LAPTOP_MONITOR,1920x1200,0x0,1.0\""
else
    hyprctl dispatch exec "hyprctl keyword monitor \"$LAPTOP_MONITOR,disable\""
fi

