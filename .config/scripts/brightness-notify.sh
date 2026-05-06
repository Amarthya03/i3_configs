#!/bin/bash
brightnessctl set "$1"
VAL=$(brightnessctl get)
MAX=$(brightnessctl max)
PCT=$((VAL*100/MAX))

if [ $PCT -ge 66 ]; then
    ICON="󰃠"
elif [ $PCT -ge 33 ]; then
    ICON="󰃟"
else
    ICON="󰃞"
fi

# dunstify -h string:x-dunst-stack-tag:brightness "Brightness" "$ICON  $PCT%" -t 1500
dunstify -h string:x-dunst-stack-tag:brightness -h int:value:$PCT "Brightness" "$ICON  $PCT%" -t 1500