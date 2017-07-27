#!/bin/sh                                                                                                                                                                                       
# Automatically setup external monitor

xrandr_command="/usr/bin/xrandr"
sed_command="/bin/sed"

is_vga_connected=`DISPLAY=:0 $xrandr_command | $sed_command -n '/VGA1 connected/p'`

is_dp1_connected=`DISPLAY=:0 $xrandr_command | $sed_command -n '/DP1 connected/p'`

if [ -n "$is_vga_connected" ]; then
  DISPLAY=:0 $xrandr_command --output VGA1 --auto --above LVDS1 
elif [ -n "$is_dp1_connected" ]; then
  DISPLAY=:0 $xrandr_command --output DP1 --auto --above LVDS1 
else
  DISPLAY=:0 $xrandr_command --output VGA1 --off
  DISPLAY=:0 $xrandr_command --output DP1 --off
fi
