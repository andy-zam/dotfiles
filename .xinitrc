#!/usr/bin/env bash

feh --bg-scale ~/Downloads/background.jpg
setxkbmap -option ctrl:nocaps

xinput set-prop 15 "libinput Natural Scrolling Enabled" 1
xinput set-prop 15 "libinput Tapping Enabled" 1

compton --backend glx --paint-on-overlay --vsync opengl-swc &

exec dwm
