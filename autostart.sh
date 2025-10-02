#!/bin/bash

export DISPLAY=:0

if [ -f "$HOME/.wallpaper.jpg" ]; then
    feh --bg-scale "$HOME/.wallpaper.jpg" &
elif [ -f "/home/runner/novnc-desktop/wallpaper.jpg" ]; then
    feh --bg-scale "/home/runner/novnc-desktop/wallpaper.jpg" &
else
    hsetroot -solid "#2c3e50" &
fi

tint2 &
