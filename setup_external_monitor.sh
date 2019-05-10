#!/usr/bin/env bash
# Automatically setup external monitor

is_vga_connected=`DISPLAY=:0 xrandr | sed -n '/VGA1 connected/p'`

is_dp1_connected=`DISPLAY=:0 xrandr | sed -n '/DP1 connected/p'`
is_hdmi1_connected=`DISPLAY=:0 xrandr | sed -n '/HDMI1 connected/p'`

is_dvi1_connected=`DISPLAY=:0 xrandr | sed -n '/DVI-I-1-1 connected/p'`
is_dvi2_connected=`DISPLAY=:0 xrandr | sed -n '/DVI-I-2-2 connected/p'`

if [ -n "$is_vga_connected" ]; then
  xrandr --newmode "1680x1050_60.00"  146.25  1680 1784 1960 2240  1050 1053 1059 1089 -hsync +vsync
  xrandr --addmode VGA1 1680x1050_60.00
  DISPLAY=:0 xrandr --output VGA1 --auto --above LVDS1 --primary
elif [ -n "$is_dp1_connected" ]; then
  DISPLAY=:0 xrandr --output DP1 --auto --above LVDS1 --primary
elif [ -n "$is_hdmi1_connected" ]; then
  #DISPLAY=:0 xrandr --output HDMI1 --auto --above LVDS1 --primary
  DISPLAY=:0 xrandr --output HDMI1 --mode 1920x1080 --above LVDS1 --primary
elif [ -n "$is_dvi1_connected" ]; then
    DISPLAY=:0 xrandr --output DVI-I-1-1 --auto --above LVDS1 --primary --rotate normal
    DISPLAY=:0 xrandr --output DVI-I-2-2 --auto  --left-of DVI-I-1-1 --rotate left
else
  DISPLAY=:0 xrandr --output VGA1 --off
  DISPLAY=:0 xrandr --output DP1 --off
  DISPLAY=:0 xrandr --output HDMI1 --off
  DISPLAY=:0 xrandr --output DVI-I-1-1 --off
  DISPLAY=:0 xrandr --output DVI-I-2-2 --off
fi

# Reset the wallpaper
~/.fehbg
