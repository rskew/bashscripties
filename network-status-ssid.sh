#!/bin/sh

essid=`nmcli | awk '/wlp3s0: connected to/ {print $4}'`

echo $essid

exit 0
