#!/usr/bin/env bash

pactl set-default-sink $(pactl list short sinks | grep -e "suspended|idle" | awk '{print $1}')
