#/usr/bin/env bash
FILENAME=$(date +'%Y-%m-%d-%H%M%S').png
grim -g "$(slurp)" $HOME/Screenshots/$FILENAME

notify-send "Screenshot saved" "Location $FILENAME"
