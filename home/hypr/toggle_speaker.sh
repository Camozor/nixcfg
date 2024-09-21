#/usr/bin/env bash

pactl set-default-sink $(pactl list short sinks | grep -E "SUSPENDED|IDLE" | awk '{print $1}')

