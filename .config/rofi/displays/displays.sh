#!/usr/bin/env bash

## Rofi : Display Switcher (i3 / X11 only, powered by xrandr)
#
## Options
#
## Mirror, Monitor Only, Laptop Screen Only,
## Extend L<-Laptop, Extend->R, Extend->Top Monitor, Extend -> Bottom Monitor

# Current Theme
dir="$HOME/.config/rofi/displays"
theme='style-1'

# Detect the laptop panel and the (first) external monitor
xr_query="$(xrandr --query)"
laptop="$(awk '/ connected/ && $1 ~ /^eDP|^LVDS/ {print $1; exit}' <<< "$xr_query")"
external="$(awk -v l="$laptop" '/ connected/ && $1 != l {print $1; exit}' <<< "$xr_query")"

# An output is "active" only if xrandr shows it with a current mode/geometry
# (WIDTHxHEIGHT+X+Y) -- merely "connected" just means it's physically plugged in.
is_active() {
	local output="$1"
	[[ -z "$output" ]] && return 1
	awk -v o="$output" '$1==o && / connected/' <<< "$xr_query" | grep -qE '[0-9]+x[0-9]+\+[0-9]+\+[0-9]+'
}

if [[ -z "$laptop" ]]; then
	notify-send "Display Switcher" "No laptop panel (eDP/LVDS) detected."
	exit 1
fi

# Options
mirror="  Mirror"
monitor_only="  External Only"
laptop_only="  Laptop Only"
extend_left="  Extend Left"
extend_right="  Extend Right"
extend_top="  Extend Above"
extend_bottom="  Extend Below"

# Nerd font icons + status chips for the message row
icon_laptop=$''
icon_monitor=$''
green='#98971a'
dark='#1d2021'
gray='#3c3836'
light='#ebdbb2'

if is_active "$laptop"; then
	chip1="<span background='${green}' foreground='${dark}'>  ${icon_laptop}  ${laptop}  </span>"
else
	chip1="<span background='${gray}' foreground='${light}'>  ${icon_laptop}  ${laptop}  </span>"
fi

if [[ -z "$external" ]]; then
	chip2="<span background='${gray}' foreground='${light}'>  ${icon_monitor}  None  </span>"
elif is_active "$external"; then
	chip2="<span background='${green}' foreground='${dark}'>  ${icon_monitor}  ${external}  </span>"
else
	chip2="<span background='${gray}' foreground='${light}'>  ${icon_monitor}  ${external}  </span>"
fi
mesg="${chip1}   ${chip2}"

# Rofi CMD
rofi_cmd() {
	rofi -dmenu \
		-p "" \
		-mesg "$mesg" \
		-theme ${dir}/${theme}.rasi
}

# Pass options to rofi dmenu
run_rofi() {
	echo -e "$mirror\n$monitor_only\n$laptop_only\n$extend_left\n$extend_right\n$extend_top\n$extend_bottom" | rofi_cmd
}

# Bail out (with a notification) if there's no external monitor to act on
require_external() {
	if [[ -z "$external" ]]; then
		notify-send "Display Switcher" "No external monitor detected."
		exit 1
	fi
}

# Actions
chosen="$(run_rofi)"
case "${chosen}" in
	"$mirror")
		require_external
		xrandr --output "$laptop" --auto --output "$external" --auto --same-as "$laptop"
		;;
	"$monitor_only")
		require_external
		xrandr --output "$external" --auto --output "$laptop" --off
		;;
	"$laptop_only")
		if [[ -n "$external" ]]; then
			xrandr --output "$laptop" --auto --output "$external" --off
		else
			xrandr --output "$laptop" --auto
		fi
		;;
	"$extend_left")
		require_external
		xrandr --output "$laptop" --auto --output "$external" --auto --left-of "$laptop"
		;;
	"$extend_right")
		require_external
		xrandr --output "$laptop" --auto --output "$external" --auto --right-of "$laptop"
		;;
	"$extend_top")
		require_external
		xrandr --output "$laptop" --auto --output "$external" --auto --above "$laptop"
		;;
	"$extend_bottom")
		require_external
		xrandr --output "$laptop" --auto --output "$external" --auto --below "$laptop"
		;;
esac
