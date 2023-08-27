#!/usr/bin/env bash

source $HOME/.config/awesome/color/desktop.sh

# Colors
BG="#f3f3f3"
FG="#000000"
BL="#4b4646"
WH="#dddddd"
R="#e70000"
G="#0abf0a"
Y="#dada00"
B="#0000ff"
M="#d7a0e6"
C="#8080ff"

# func (change colors in #Colors section)
term 
# func - gtk - icons 
gtk "macintosh" "Qogir" 
# wall
cp ~/.config/awesome/color/macintosh/.fehbg ~/
./.fehbg
