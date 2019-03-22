#!/bin/sh
# Automatically setup external monitor

xrandr_command="/usr/bin/xrandr"
sed_command="/bin/sed"

is_vga_connected=`DISPLAY=:0 $xrandr_command | $sed_command -n '/VGA-1 connected/p'`

is_dp1_connected=`DISPLAY=:0 $xrandr_command | $sed_command -n '/DP-1 connected/p'`
is_hdmi1_connected=`DISPLAY=:0 $xrandr_command | $sed_command -n '/HDMI-1 connected/p'`

is_dvi1_connected=`DISPLAY=:0 $xrandr_command | $sed_command -n '/DVI-I-1-1 connected/p'`
is_dvi2_connected=`DISPLAY=:0 $xrandr_command | $sed_command -n '/DVI-I-2-2 connected/p'`

if [ -n "$is_vga_connected" ]; then
  $xrandr_command --newmode "1680x1050_60.00"  146.25  1680 1784 1960 2240  1050 1053 1059 1089 -hsync +vsync
  $xrandr_command --addmode VGA-1 1680x1050_60.00
  DISPLAY=:0 $xrandr_command --output VGA-1 --auto --above LVDS-1 --primary
elif [ -n "$is_dp1_connected" ]; then
  DISPLAY=:0 $xrandr_command --output DP-1 --auto --above LVDS-1 --primary
elif [ -n "$is_hdmi1_connected" ]; then
  DISPLAY=:0 $xrandr_command --output HDMI-1 --auto --above LVDS-1 --primary
elif [ -n "$is_dvi1_connected" ]; then
    DISPLAY=:0 $xrandr_command --output DVI-I-1-1 --auto --above LVDS-1 --primary --rotate normal
    DISPLAY=:0 $xrandr_command --output DVI-I-2-2 --auto  --left-of DVI-I-1-1 --rotate left
else
  DISPLAY=:0 $xrandr_command --output VGA-1 --off
  DISPLAY=:0 $xrandr_command --output DP-1 --off
  DISPLAY=:0 $xrandr_command --output HDMI-1 --off
  DISPLAY=:0 $xrandr_command --output DVI-I-1-1 --off
  DISPLAY=:0 $xrandr_command --output DVI-I-2-2 --off
fi

# Reset the wallpaper
~/.fehbg
