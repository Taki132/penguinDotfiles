#!/bin/sh

source $HOME/.config/awesome/color/desktop.sh

# Colors
BG="#24273a"
FG="#cad3f5"
BL="#494d64"
WH="#b8c0e0"
R="#ed8796"
G="#a6da95"
Y="#eed49f"
B="#8aadf4"
M="#f5bde6"
C="#8bd5ca"

# func (change colors in #Colors section)
term 
# func - gtk - icons 
gtk "Catppuccin-Macchiato" "Qogir-dark" 
# wall
cp ~/.config/awesome/color/catppuccin/.fehbg ~/
./.fehbg
