#!/bin/sh

# Xresources
xrdb merge ~/.Xresources

# Start Awesome WM
exec awesome
