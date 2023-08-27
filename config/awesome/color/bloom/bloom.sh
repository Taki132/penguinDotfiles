#!/usr/bin/env bash

source $HOME/.config/awesome/color/desktop.sh

# Colors
BG="#fffaf5"
FG="#4b4646"
BL="#4b4646"
WH="#ebe6e1"
R="#eb8c8c"
G="#96e6a5"
Y="#f0cd96"
B="#9bb9f0"
M="#d7a0e6"
C="#a0e1d2"

# func (change colors in #Colors section)
term 
# func - gtk - icons 
gtk "bloom" "Qogir" 
# wall
cp ~/.config/awesome/color/bloom/.fehbg ~/
./.fehbg
