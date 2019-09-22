#!/bin/sh
#
#             _       _ _            
#       __  _(_)_ __ (_) |_ _ __ ___ 
#       \ \/ / | '_ \| | __| '__/ __|
#        >  <| | | | | | |_| | | (__ 
#       /_/\_\_|_| |_|_|\__|_|  \___|
#

# Mute speaker
amixer sset Speaker mute

# Set monitor if connected
$HOME/.local/bin/externalMonitor

# Set cursor theme
xsetroot -cursor_name left_ptr

# Load keybind
sxhkd &

# Start bspwm 
exec bspwm
