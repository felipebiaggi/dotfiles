#!/bin/sh

xrandr --output DP-0 --primary --mode 3840x2160 --pos 0x0
xrandr --output HDMI-0 --mode 2560x1080 --pos 3840x0

[ -f "$HOME/.Xresources" ] && xrdb -merge "$HOME/.Xresources"

export XFT_DPI=240
export QT_FONT_DPI=240
export GDK_SCALE=1
export GDK_DPI_SCALE=1
export QT_AUTO_SCREEN_SCALE_FACTOR=0
export QT_SCALE_FACTOR=1

exec dbus-run-session i3

