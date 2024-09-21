#!/usr/bin/env bash

# Check if the microphone is muted
MUTE_STATUS=$(pactl get-source-mute @DEFAULT_SOURCE@ | grep "oui")

if [ -n "$MUTE_STATUS" ]; then
	echo '{"text": "🔇 Micro", "class": "muted"}'
else
    echo '{"text": "🎤 Micro", "class": "unmuted"}'
fi
