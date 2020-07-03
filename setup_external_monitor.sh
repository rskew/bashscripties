#!/usr/bin/env bash
# Automatically setup external monitor

POSITION_EXT_TO_LAPPY="left-of"
#POSITION_EXT_TO_LAPPY="above"

is_vga_connected=`DISPLAY=:0 xrandr | sed -n '/VGA-1 connected/p'`

is_dp1_connected=`DISPLAY=:0 xrandr | sed -n '/DP-1 connected/p'`
is_hdmi1_connected=`DISPLAY=:0 xrandr | sed -n '/HDMI-1 connected/p'`

is_dvi1_connected=`DISPLAY=:0 xrandr | sed -n '/DVI-I-1-1 connected/p'`
is_dvi2_connected=`DISPLAY=:0 xrandr | sed -n '/DVI-I-2-2 connected/p'`

if [ -n "$is_vga_connected" ]; then
  xrandr --newmode "1680x1050_60.00"  146.25  1680 1784 1960 2240  1050 1053 1059 1089 -hsync +vsync
  xrandr --addmode VGA-1 1680x1050_60.00
  DISPLAY=:0 xrandr --output VGA-1 --auto --"$POSITION_EXT_TO_LAPPY" LVDS-1 --primary
elif [ -n "$is_dp1_connected" ]; then
  # for biiiiig screen at work:
  #xrandr --newmode "3840x2160_30.00"  338.75  3840 4080 4488 5136  2160 2163 2168 2200 -hsync +vsync
  #xrandr --addmode DP-1 3840x2160_30.00
  #DISPLAY=:0 xrandr --output DP-1 --auto --"$POSITION_EXT_TO_LAPPY" LVDS-1 --primary --mode "3840x2160_30.00" --verbose
  #DISPLAY=:0 xrandr --output DP-1 --auto --"$POSITION_EXT_TO_LAPPY" LVDS-1 --primary --mode "3840x2160"
  DISPLAY=:0 xrandr --output DP-1 --auto --"$POSITION_EXT_TO_LAPPY" LVDS-1 --primary
elif [ -n "$is_hdmi1_connected" ]; then
  DISPLAY=:0 xrandr --output HDMI-1 --auto --"$POSITION_EXT_TO_LAPPY" LVDS-1 --primary
  #DISPLAY=:0 xrandr --output HDMI-1 --auto --"$POSITION_EXT_TO_LAPPY" LVDS-1 --primary --mode "800x600"
elif [ -n "$is_dvi1_connected" ]; then
  DISPLAY=:0 xrandr --output DVI-I-1-1 --auto --"$POSITION_EXT_TO_LAPPY" LVDS-1 --primary --rotate normal
  DISPLAY=:0 xrandr --output DVI-I-2-2 --auto  --"$POSITION_EXT_TO_LAPPY" DVI-I-1-1 --rotate left
else
  DISPLAY=:0 xrandr --output VGA-1 --off
  DISPLAY=:0 xrandr --output DP-1 --off
  DISPLAY=:0 xrandr --output HDMI-1 --off
  DISPLAY=:0 xrandr --output DVI-I-1-1 --off
  DISPLAY=:0 xrandr --output DVI-I-2-2 --off
fi

# Reset the wallpaper
~/.fehbg
